# frozen_string_literal: true

module Extensiv
  class CartInventory < Resource
    def list(**params)
      response = get_request("merchant/inventory", params: params)
      Collection.from_response(response, type: Inventory, params: params)
    end

    def retrieve(sku:)
      Inventory.new get_request("merchant/inventory/#{sku}").body["response"]
    end
  end
end
