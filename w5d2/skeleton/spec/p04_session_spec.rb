require 'webrick'
require 'phase4/session'
require 'phase4/controller_base'

describe Phase4::Session do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cook) { WEBrick::Cookie.new('_rails_lite_app', { xyz: 'abc' }.to_json) }

  it "deserializes json cookie if one exists" do
    req.cookies << cook
    session = Phase4::Session.new(req)
    session['xyz'].should == 'abc'
  end

  describe "#store_session" do
    context "without cookies in request" do
      before(:each) do
        session = Phase4::Session.new(req)
        session['first_key'] = 'first_val'
        session.store_session(res)
      end

      it "adds new cookie with '_rails_lite_app' name to response" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        cookie.should_not be_nil
      end

      it "stores the cookie in json format" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        JSON.parse(cookie.value).should be_instance_of(Hash)
      end
    end

    context "with cookies in request" do
      before(:each) do
        cook = WEBrick::Cookie.new('_rails_lite_app', { pho: "soup" }.to_json)
        req.cookies << cook
      end

      it "reads the pre-existing cookie data into hash" do
        session = Phase4::Session.new(req)
        session['pho'].should == 'soup'
      end

      it "saves new and old data to the cookie" do
        session = Phase4::Session.new(req)
        session['machine'] = 'mocha'
        session.store_session(res)
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
        h = JSON.parse(cookie.value)
        h['pho'].should == 'soup'
        h['machine'].should == 'mocha'
      end
    end
  end
end

describe Phase4::ControllerBase do
  before(:all) do
    class CatsController < Phase4::ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#session" do
    it "returns a session instance" do
      expect(cats_controller.session).to be_a(Phase4::Session)
    end

    it "returns the same instance on successive invocations" do
      first_result = cats_controller.session
      expect(cats_controller.session).to be(first_result)
    end
  end

  shared_examples_for "storing session data" do
    it "should store the session data" do
      cats_controller.session['test_key'] = 'test_value'
      cats_controller.send(method, *args)
      cookie = res.cookies.find { |c| c.name == '_rails_lite_app' }
      h = JSON.parse(cookie.value)
      expect(h['test_key']).to eq('test_value')
    end
  end

  describe "#render_content" do
    let(:method) { :render_content }
    let(:args) { ['test', 'text/plain'] }
    include_examples "storing session data"
  end

  describe "#redirect_to" do
    let(:method) { :redirect_to }
    let(:args) { ['http://appacademy.io'] }
    include_examples "storing session data"
  end
end
