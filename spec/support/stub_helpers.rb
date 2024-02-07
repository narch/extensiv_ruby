# frozen_string_literal: true

require "extensiv"
require "faraday"
require "json"

module StubHelpers
  BASE_URL = "https://api.cartrover.com/v1"

  def stub_response(fixture:, status: 200, headers: { "Content-Type" => "application/json" })
    [status, headers, File.read("spec/fixtures/#{fixture}.json")]
  end

  def stub_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "#{BASE_URL}/#{path}"]
      arguments << body.to_json if %w[:post :put :patch].include?(method)
      stub.send(*arguments) { |_env| response }
    end
  end
end
