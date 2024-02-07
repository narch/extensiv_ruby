# frozen_string_literal: true

module Extensiv
  class CartOrder < Resource
    def retrieve(cust_ref:)
      Order.new get_request("cart/orders/#{cust_ref}").body["response"]
    end

    def status(cust_ref:)
      OrderStatus.new get_request("cart/orders/status/#{cust_ref}").body["response"]
    end

    def list(status:, **params)
      response = get_request("cart/orders/list/#{status}", params: params)
      Collection.from_response(response, type: Order, params: params)
    end

    def create(**attributes)
      Response.new post_request("cart/orders/cartrover", body: attributes).body
    end

    def batch_create(*attributes)
      Response.new post_request("cart/orders/batch", body: attributes).body["response"]
    end

    def cancel(cust_ref:)
      Response.new get_request("cart/orders/wms_cancel/#{cust_ref}").body["response"]
    end

    def update_status_confirmed(cust_ref:, **attributes)
      Response.new post_request("cart/orders/update/#{cust_ref}", body: attributes).body
    end
  end
end
