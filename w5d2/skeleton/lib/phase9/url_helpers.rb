module Phase9
  module URLHelpers

    def link_to(name, route)
      name
    end

    def button_to(name, route, method= :post)
      name
    end

    def urlhelpergenerator(method, controller_class, action_name)
      controller_name = controller_class.to_s.gsub("Controller", "").downcase
      controller_name = controller_name.singularize unless action_name == :index
      URLHelpers.send(define_method(controller_name) { |argument| "/cats" })
    end

    def name_helper(name)
      {index: '_url', show: '_url(option = nil)', :new => 'new', edit: '_url(option = nil)' }
    end
  end
end