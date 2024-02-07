# frozen_string_literal: true

require "json"

RSpec.describe Extensiv::CartOrder do
  let(:cust_ref) { "TEST07Auto" }
  let(:status) { "at_wms" }

  describe "#retrieve" do
    it "gets order by customer reference" do
      stub = stub_request("cart/orders/#{cust_ref}", response: stub_response(fixture: "cart/orders/retrieve"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      order = client.order.retrieve(cust_ref: cust_ref)
      expect(order.cust_ref).to eq(cust_ref)
    end
  end

  describe "#status" do
    it "gets status of order" do
      stub = stub_request("cart/orders/status/#{cust_ref}", response: stub_response(fixture: "cart/orders/status"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      order = client.order.status(cust_ref: cust_ref)
      expect(order.order_status).to eq("shipped")
    end
  end

  describe "#list" do
    it "returns a collection of order objects by status" do
      stub = stub_request("cart/orders/list/#{status}", response: stub_response(fixture: "cart/orders/list"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      orders = client.order.list(status: status)
      expect(orders.class).to eq(Extensiv::Collection)
      expect(orders.data.first.class).to eq(Extensiv::Order)
      expect(orders.data.first.record_no).to eq("156")
    end
  end

  describe "#create" do
    it "creates a new order" do
      data = JSON.parse(File.read("spec/fixtures/cart/orders/create_data.json"))
      stub = stub_request("cart/orders/cartrover", method: :post, body: data, response: stub_response(fixture: "cart/orders/create"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      order = client.order.create(**data)
      expect(order.class).to eq(Extensiv::Response)
      expect(order.cust_ref).to eq("TEST21")
    end
  end

  describe "#batch_create" do
    it "creates a batch of orders" do
      data = JSON.parse(File.read("spec/fixtures/cart/orders/batch_create_data.json"))
      stub = stub_request("cart/orders/batch", method: :post, body: data, response: stub_response(fixture: "cart/orders/batch_create"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      response = client.order.batch_create(*data)
      expect(response.class).to eq(Extensiv::Response)
      expect(response.success).to be_an_instance_of(Array)
    end
  end

  describe "#cancel" do
    it "attempts to cancel order" do 
      data = JSON.parse(File.read("spec/fixtures/cart/orders/update_status_confirmed_data.json"))
      stub = stub_request("cart/orders/update/#{cust_ref}", method: :post, body: data, response: stub_response(fixture: "cart/orders/update_status_confirmed"))
      client = Extensiv::CartClient.new(api_user: "testing", api_key: "123", adapter: :test, stubs: stub)
      response = client.order.update_status_confirmed(cust_ref: cust_ref, **data)
      expect(response.success_code).to eq(true)
    end
  end
end
