# frozen_string_literal: true

RSpec.describe Extensiv::CartShipMethod do
  describe "#list" do
    it "returns a collection of shipping method objects" do
      stub = stub_request("wms/shipmethod/list", response: stub_response(fixture: "cart/shipping_methods/list"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      ship_methods = client.ship_method.list
      expect(ship_methods.class).to eq(Extensiv::Collection)
      expect(ship_methods.data.first.class).to eq(Extensiv::ShipMethod)
      expect(ship_methods.data.last.description).to eq("DHLGM Parcel Intl Standard")
      expect(ship_methods.data.last.carrier).to be_empty
    end
  end
end
