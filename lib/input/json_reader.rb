# frozen_string_literal: true

require 'json'
require 'product'

class JsonReader
  def initialize(input)
    @input = input
  end

  def product_list
    JSON.parse(@input).map do |product|
      Product.create(product['uuid'], product['name'], product['price'])
    end
  end
end
