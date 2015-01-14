require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_accessor :params

    # setup the controller
    def initialize(req, res, route_params = {})
      @params = Params.new(req, route_params)
      super(req, res)
    end
  end
end
