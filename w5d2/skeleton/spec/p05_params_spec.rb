require 'webrick'
require 'phase5/params'
require 'phase5/controller_base'

describe Phase5::Params do
  before(:all) do
    class CatsController < Phase5::ControllerBase
      def index
        @cats = ["Gizmo"]
      end
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  it "handles an empty request" do
    expect { Phase5::Params.new(req) }.to_not raise_error
  end

  context "query string" do
    it "handles single key and value" do
      req.query_string = "key=val"
      params = Phase5::Params.new(req)
      params["key"].should == "val"
    end

    it "handles multiple keys and values" do
      req.query_string = "key=val&key2=val2"
      params = Phase5::Params.new(req)
      params["key"].should == "val"
      params["key2"].should == "val2"
    end

    it "handles nested keys" do
      req.query_string = "user[address][street]=main"
      params = Phase5::Params.new(req)
      params["user"]["address"]["street"].should == "main"
    end
  end

  context "post body" do
    it "handles single key and value" do
      req.stub(:body) { "key=val" }
      params = Phase5::Params.new(req)
      params["key"].should == "val"
    end

    it "handles multiple keys and values" do
      req.stub(:body) { "key=val&key2=val2" }
      params = Phase5::Params.new(req)
      params["key"].should == "val"
      params["key2"].should == "val2"
    end

    it "handles nested keys" do
      req.stub(:body) { "user[address][street]=main" }
      params = Phase5::Params.new(req)
      params["user"]["address"]["street"].should == "main"
    end

    it "handles multiple nested keys" do
      req.stub(:body) { "user[address][street]=main&user[address][zip]=89436" }
      params = Phase5::Params.new(req)
      params["user"]["address"]["street"].should == "main"
      params["user"]["address"]["zip"].should == "89436"
    end
  end

  context "route params" do
    it "handles route params" do
      params = Phase5::Params.new(req, {"id" => 5, "user_id" => 22})
      params["id"].should == 5
      params["user_id"].should == 22
    end
  end

  # describe "strong parameters" do
  #   describe "#permit" do
  #     it "allows the permitting of multiple attributes" do
  #       req.query_string = "key=val&key2=val2&key3=val3"
  #       params = Phase5::Params.new(req)
  #       params.permit("key", "key2")
  #       params.permitted?("key").should be true
  #       params.permitted?("key2").should be true
  #       params.permitted?("key3").should be false
  #     end
  #
  #     it "collects up permitted keys across multiple calls" do
  #       req.query_string = "key=val&key2=val2&key3=val3"
  #       params = Phase5::Params.new(req)
  #       params.permit("key")
  #       params.permit("key2")
  #       params.permitted?("key").should be true
  #       params.permitted?("key2").should be true
  #       params.permitted?("key3").should be false
  #     end
  #   end
  #
  #   describe "#require" do
  #     it "throws an error if the attribute does not exist" do
  #       req.query_string = "key=val"
  #       params = Phase5::Params.new(req)
  #       expect { params.require("key") }.to_not raise_error
  #       expect { params.require("key2") }.to raise_error(Phase5::Params::AttributeNotFoundError)
  #     end
  #   end
  #
  #   describe "interaction with ARLite models" do
  #     it "throws a ForbiddenAttributesError if mass assignment is attempted with unpermitted attributes" do
  #
  #     end
  #   end
  # end
end
