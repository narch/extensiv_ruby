# frozen_string_literal: true

require "faraday"
require "base64"

module Extensiv
  class Client
    BASE_URL = "https://api.cartrover.com/v1/"

    attr_reader :api_user, :api_key, :adapter, :stubs, :auth_key

    def initialize(api_user:, api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_user = api_user
      @api_key = api_key
      @adapter = adapter
      @stubs = stubs
      @auth_key = Base64.strict_encode64("#{@api_user}:#{@api_key}")
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.headers = { Authorization: "Basic #{@auth_key}" }
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end
  end
end
