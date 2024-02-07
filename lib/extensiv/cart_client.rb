# frozen_string_literal: true

module Extensiv
  class CartClient < Client
    def inventory
      CartInventory.new(self)
    end

    def order
      CartOrder.new(self)
    end

    def product
      CartProduct.new(self)
    end

    def ship_method
      CartShipMethod.new(self)
    end
  end
end
