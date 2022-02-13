# frozen_string_literal: true

require_relative 'output/text_output'

class Product
  @@display_method = TextOutput.new
  attr_reader :uuid, :name, :price

  private_class_method :new

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

    new(uuid, name, price)
  end

  def to_s
    @@display_method.display_product(self)
  end
end
