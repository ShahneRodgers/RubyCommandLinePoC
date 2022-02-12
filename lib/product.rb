# frozen_string_literal: true

class Product
  attr_reader :uuid, :name, :price

  def initialize(uuid, name, price)
    @uuid = uuid
    @name = name
    @price = price
  end

  def self.create(uuid, name, price)
    raise 'Invalid uuid' unless uuid.is_a?(Integer) # Might want uniqueness checks?
    raise 'Invalid name' if name.nil? || name == ''

    price = price.to_f
    raise 'Invalid price' if price <= 0

    Product.new(uuid, name, price)
  end
end
