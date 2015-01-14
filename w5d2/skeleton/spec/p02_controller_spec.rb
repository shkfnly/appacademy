require 'webrick'
require 'phase2/controller_base'

describe Phase2::ControllerBase do
  before(:all) do
    class UsersController < Phase2::ControllerBase
      def index
      end
    end
  end
  after(:all) { Object.send(:remove_const, "UsersController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:users_controller) { UsersController.new(req, res) }

  describe "#render_content" do
    before(:each) do
      users_controller.render_content "somebody", "text/html"
    end

    it "sets the response content type" do
      users_controller.res.content_type.should == "text/html"
    end

    it "sets the response body" do
      users_controller.res.body.should == "somebody"
    end

    describe "#already_built_response?" do
      let(:users_controller2) { UsersController.new(req, res) }

      it "is false before rendering" do
        users_controller2.already_built_response?.should be false
      end

      it "is true after rendering content" do
        users_controller2.render_content "sombody", "text/html"
        users_controller2.already_built_response?.should be true
      end

      it "raises an error when attempting to render twice" do
        users_controller2.render_content "sombody", "text/html"
        expect do
          users_controller2.render_content "sombody", "text/html"
        end.to raise_error
      end
    end
  end

  describe "#redirect" do
    before(:each) do
      users_controller.redirect_to("http://www.google.com")
    end

    it "sets the header" do
      users_controller.res.header["location"].should == "http://www.google.com"
    end

    it "sets the status" do
      users_controller.res.status.should == 302
    end

    describe "#already_built_response?" do
      let(:users_controller2) { UsersController.new(req, res) }

      it "is false before rendering" do
        users_controller2.already_built_response?.should be false
      end

      it "is true after rendering content" do
        users_controller2.redirect_to("http://google.com")
        users_controller2.already_built_response?.should be true
      end

      it "raises an error when attempting to render twice" do
        users_controller2.redirect_to("http://google.com")
        expect do
          users_controller2.redirect_to("http://google.com")
        end.to raise_error
      end
    end
  end
end
