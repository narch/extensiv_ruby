# frozen_string_literal: true

module Extensiv
  class CartProduct < Resource
    def info(sku:)
      Product.new get_request("merchant/product/#{sku}").body["response"]
    end
  end
end
