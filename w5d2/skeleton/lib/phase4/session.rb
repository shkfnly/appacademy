require 'json'
require 'webrick'


module Phase4
  class Session
    attr_accessor :cookie
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = req.cookies.select do |cookie|
        cookie.name == '_rails_lite_app'
      end.first
      @cookie ? @cookie = JSON.parse(@cookie.value) : @cookie = Hash.new
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
    end
  end
end
