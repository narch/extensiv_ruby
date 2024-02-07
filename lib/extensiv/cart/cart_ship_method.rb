# frozen_string_literal: true

module Extensiv
  class CartShipMethod < Resource
    def list(**params)
      response = get_request("wms/shipmethod/list", params: params)
      Collection.from_response(response, type: ShipMethod, params: params)
    end
  end
end
