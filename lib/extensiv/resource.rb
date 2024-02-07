# frozen_string_literal: true

module Extensiv
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    # CartRover's API only supports GET and POST requests

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    # CartRover's API uses a 200 status for all request
    # unless there is a server-side error

    def handle_response(response)
      if response.status != 200
        raise Error, "We were unable to perform the request due to server-side problems."
      elsif response.body["success_code"] == false
        raise Error, response.body["message"]
      end

      response
    end
  end
end
