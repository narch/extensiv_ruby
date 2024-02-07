# frozen_string_literal: true

RSpec.describe Extensiv::CartInventory do
  let(:sku) { "CIO-1001" }

  describe "#list" do
    it "returns a collection of inventory objects" do
      stub = stub_request("merchant/inventory", response: stub_response(fixture: "cart/inventory/list"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      inventory = client.inventory.list
      expect(inventory.class).to eq(Extensiv::Collection)
      expect(inventory.data.first.class).to eq(Extensiv::Inventory)
      expect(inventory.data.first.sku).to eq(sku)
    end
  end

  describe "#retrieve" do
    it "returns inventory level for single product sku" do
      stub = stub_request("merchant/inventory/#{sku}", response: stub_response(fixture: "cart/inventory/retrieve"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      inventory = client.inventory.retrieve(sku: sku)
      expect(inventory.class).to eq(Extensiv::Inventory)
      expect(inventory.sku).to eq(sku)
    end
  end
end
