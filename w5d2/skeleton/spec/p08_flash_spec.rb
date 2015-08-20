require 'webrick'
require 'phase8/flash'
require 'phase8/controller_base'

describe Phase8::Flash do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cook) do
    WEBrick::Cookie.new('_rails_lite_app_flash', { xyz: 'abc' }.to_json)
  end

  it "deserializes json cookie if one exists" do
    req.cookies << cook
    flash = Phase8::Flash.new(req)
    expect(flash['xyz']).to eq('abc')
  end

  describe '#now' do
    it 'returns a hash' do
      flash = Phase8::Flash.new(req)
      expect(flash.now).to respond_to(:[])
    end

    it 'does not persist beyond first request' do
      flash = Phase8::Flash.new(req)
      flash.now[:errors] = "Error"
      flash.store_flash(res)
      simulate_req_res!(req, res)
      flash2 = Phase8::Flash.new(req)
      expect(flash2[:errors]).to be_nil
      expect(flash2.now[:errors]).to be_nil
    end

    it 'allows access to the data from top level flash :[]' do
      flash = Phase8::Flash.new(req)
      flash.now[:errors] = "Error"
      expect(flash[:errors]).to eq("Error")
    end
  end

  describe "#store_flash" do
    context "without cookies in request" do
      before(:each) do
        flash = Phase8::Flash.new(req)
        flash['first_key'] = 'first_val'
        flash.store_flash(res)
      end

      it "adds new cookie with '_rails_lite_app_flash' name to response" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app_flash' }
        expect(cookie).not_to be_nil
      end

      it "stores the cookie in json format" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_app_flash' }
        expect(JSON.parse(cookie.value)).to be_instance_of(Hash)
      end
    end

    context "with cookies in request" do
      before(:each) do
        cook = WEBrick::Cookie.new('_rails_lite_app_flash', { pho: "soup" }.to_json)
        req.cookies << cook
      end

      it "reads the pre-existing cookie data into hash" do
        flash = Phase8::Flash.new(req)
        expect(flash['pho']).to eq('soup')
      end
    end
  end

  it "can be accessed using either strings or symbols" do
    flash = Phase8::Flash.new(req)
    flash["notice"] = "test"
    expect(flash[:notice]).to eq("test")
  end

  it "only saves data stored directly in flash for one more request" do
    flash = Phase8::Flash.new(req)
    flash['first_request'] = 'first'
    flash.store_flash(res)

    simulate_req_res!(req, res)

    flash2 = Phase8::Flash.new(req)
    flash2.store_flash(res)
    expect(flash2['first_request']).to eq('first')

    simulate_req_res!(req, res)

    flash3 = Phase8::Flash.new(req)
    expect(flash3['first_request']).to be_nil
  end
end

describe Phase8::ControllerBase do
  before(:all) do
    class CatsController < Phase8::ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#flash" do
    it "returns a flash instance" do
      expect(cats_controller.flash).to be_a(Phase8::Flash)
    end

    it "returns the same instance on successive invocations" do
      first_result = cats_controller.flash
      expect(cats_controller.flash).to be(first_result)
    end
  end

  shared_examples_for "storing flash data" do
    it "should store the flash data" do
      cats_controller.flash['test_key'] = 'test_value'
      cats_controller.send(method, *args)
      cookie = res.cookies.find { |c| c.name == '_rails_lite_app_flash' }
      h = JSON.parse(cookie.value)
      expect(h['test_key']).to eq('test_value')
    end
  end

  describe "#render_content" do
    let(:method) { :render_content }
    let(:args) { ['test', 'text/plain'] }
    include_examples "storing flash data"
  end

  describe "#redirect_to" do
    let(:method) { :redirect_to }
    let(:args) { ['http://appacademy.io'] }
    include_examples "storing flash data"
  end
end

def simulate_req_res!(req, res)
  req.cookies.delete_if { true }
  req.cookies.concat(res.cookies)
  res.cookies.delete_if { true }
end
