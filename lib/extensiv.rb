# frozen_string_literal: true

require_relative "extensiv/version"

module Extensiv
  autoload :Client, "extensiv/client"
  autoload :Resource, "extensiv/resource"
  autoload :Collection, "extensiv/collection"
  autoload :CartClient, "extensiv/cart_client"
  autoload :CartInventory, "extensiv/cart/cart_inventory"
  autoload :CartOrder, "extensiv/cart/cart_order"
  autoload :CartProduct, "extensiv/cart/cart_product"
  autoload :CartShipMethod, "extensiv/cart/cart_ship_method"
  autoload :Error, "extensiv/error"

  # Object Classes
  autoload :Object, "extensiv/object"
  autoload :Order, "extensiv/objects/order"
  autoload :OrderStatus, "extensiv/objects/order_status"
  autoload :Inventory, "extensiv/objects/inventory"
  autoload :Product, "extensiv/objects/product"
  autoload :ShipMethod, "extensiv/objects/ship_method"
  autoload :Response, "extensiv/objects/response" # for generic responses
end
