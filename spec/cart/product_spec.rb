# frozen_string_literal: true

RSpec.describe Extensiv::CartProduct do
  let(:sku) { "CIO-1001" }

  describe "#info" do
    it "returns product sku information" do
      stub = stub_request("merchant/product/#{sku}", response: stub_response(fixture: "cart/products/info"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      product = client.product.info(sku: sku)
      expect(product.class).to eq(Extensiv::Product)
      expect(product.description).to eq("It's a wonderful product")
    end
  end
end
