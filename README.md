# Extensiv API Rubygem

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

A friendly ruby interface to the Extensiv/CartRover API. 

CartRover's API has four different levels. Cart, Merchant, Warehouse, and Master. This gem currently offers access to the Cart API only. 

API documentation is available at https://developers.cartrover.com/

## Installation

Add this line to your application's Gemfile:

    gem "extensiv_ruby"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extensiv_ruby

## Cart API

To access the API, you'll need to create a `Extensiv::CartClient` and pass in your api_user and api_key.

```ruby
client = Extensiv::CartClient.new(api_user: ENV["CARTROVER_API_USER"], api_key: ENV["CARTROVER_API_KEY"])
```
#### Orders
```ruby
client.order.retrieve(cust_ref: "ref")
#=> Extensiv::Order

client.order.status(cust_ref: "ref")
#=> Extensiv::OrderStatus

# Possible order statuses: new, at_wms, shipped, confirmed, error, canceled, new_or_at_wms, shipped_or_confirmed, any
client.order.list(status: "ref", {limit: 20})
#=> Extensiv::Collection

client.order.create({})
#=> Extensiv::Response

client.order.batch_create([{}])
#=> Extensiv::Response

client.order.cancel(cust_ref: "ref")
#=> Extensiv::Response

client.order.update_status_confirmed(cust_ref: "ref", {})
#=> Extensiv::Response
```
#### Inventory
```ruby
client.inventory.list({})
#=> Extensiv::Collection

client.inventory.retrieve(sku: "sku_id")
#=> Extensiv::Inventory
```

#### Product
```ruby
client.product.info(sku: "sku_id")
#=> Extensiv::Product
```
#### Shipping Methods
```ruby
client.ship_methods.list({})
#=> Extensiv::Collection
```

## Copyright

Copyright (c) 2024 Nathan Williams. See [LICENSE.txt](LICENSE.txt) for
further details.
