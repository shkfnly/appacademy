require 'json'
require 'webrick'

module Phase8 
  class Flash

    def initialize(req)
      flash_cookie = req.cookies.find do |cookie|
        cookie.name == '_rails_lite_app_flash'
      end
      @now_flash = {}
      if flash_cookie.nil?
       @now_flash
      else
        JSON.parse(flash_cookie.value).each do |k, v|
          @now_flash[k.to_sym] = v
        end
      end
      @next_flash = {}
    end

    def now
      @now_flash
    end

    def [](key)
      unless @now_flash.empty?
        @now_flash[key.to_sym]
      else
        @next_flash[key.to_sym]
      end
    end

    def []=(key, value)
      @next_flash[key.to_sym]=value
    end

    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', @next_flash.to_json)

    end
  end
end