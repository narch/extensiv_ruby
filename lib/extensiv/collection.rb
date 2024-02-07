# frozen_string_literal: true

module Extensiv
  class Collection
    attr_reader :data, :next_page, :prev_page

    def self.from_response(response, type:, params: nil)
      body = response.body
      new(
        data: body["response"].map { |attrs| type.new(attrs) },
        next_page: params.empty? ? 2 : next_page(params),
        prev_page: params.empty? ? nil : prev_page(params)
      )
    end

    def initialize(data:, next_page:, prev_page:)
      @data = data
      @next_page = next_page
      @prev_page = prev_page
    end

    def self.next_page(params)
      return @next_page = params[:page].to_i + 1 if params[:page].present? && params[:page].to_i >= 1

      @next_page = 2
    end

    def self.prev_page(params)
      return @prev_page = params[:page].to_i - 1 if params[:page].present? && params[:page].to_i > 1

      @prev_page = nil
    end
  end
end
