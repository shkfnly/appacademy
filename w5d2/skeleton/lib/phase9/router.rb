require_relative '../phase6/router'
module Phase9
  class Router < Phase6::Router
    extend Phase9::URLHelpers
    def add_route(pattern, method, controller_class, action_name)
      URLHelpers.class.send(urlhelpergenerator(method, controller_class, action_name))
      super
    end
  end


end