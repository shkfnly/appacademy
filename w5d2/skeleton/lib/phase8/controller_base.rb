require_relative '../phase6/controller_base'

module Phase8
  class ControllerBase < Phase6::ControllerBase
    def redirect_to(url)
      super
      flash.store_flash(res)
    end

    def render_content(content, type)
      super
      flash.store_flash(res)
    end

    def flash
      @flash ||= Flash.new(req)
    end
  end
end