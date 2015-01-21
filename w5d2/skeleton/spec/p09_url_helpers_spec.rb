require 'webrick'
require 'phase9/url_helpers'
require 'phase9/controller_base'
require 'phase9/router'

describe Phase9::Router do
  subject(:router) { Phase9::Router.new }
  before(:all) do
    class CatsController < Phase9::ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  it 'registers url helper methods when route is added' do
    router.get Regexp.new("^/cats$"), CatsController, :index
    expect(cats_controller.cats_url).to eq("/cats")
  end

  it 'helper methods take arguments' do
    router.get Regexp.new("^/cats/(<id>\\d+)/edit$"), CatsController, :edit
    expect(cats_controller.edit_cat_url(7)).to eq("/cats/7/edit")
  end
end

describe Phase9::ControllerBase do
  before(:all) do
    class CatsController < Phase9::ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#link_to" do
    it "is added to controller class" do
      expect(cats_controller).to respond_to(:link_to)
    end

    it 'returns a link' do
      link_html = cats_controller.link_to("test link", "/cool/path")
      expect(link_html).to eq("<a href='/cool/path'>test link</a>")
    end
  end

  describe "#button_to" do
    it "is added to controller class" do
      expect(cats_controller).to respond_to(:button_to)
    end

    it 'returns a form with a button' do
      link_html = cats_controller.button_to("test btn", "/cool/path")
      expect(link_html).to eq("<form action='/cool/path' method='post'><input type='submit' value='test btn'></form>")
    end

    it 'returns a form with a button and method' do
      link_html = cats_controller.button_to("test btn", "/cool/path", method: :patch)
      expect(link_html).to eq("<form action='/cool/path' method='post'><input type='hidden' name='_method' value='patch'><input type='submit' value='test btn'></form>")
    end
  end
end
