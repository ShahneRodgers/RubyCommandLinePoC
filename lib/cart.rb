# frozen_string_literal: true

require_relative 'output/text_output'
require_relative 'discounts/discount'

class Cart
  attr_reader :items

  @@display_method = TextOutput.new

  def initialize
    @items = {}
    @items.default = 0
  end

  def add_product(product)
    @items[product] += 1
  end

  def remove_product(product)
    raise 'Invalid operation: cannot have negative amounts of item' if @items[product] <= 0

    @items[product] -= 1
    @items.delete(product) if (@items[product]).zero?
  end

  def calculate_total
    Total.new(self)
  end

  def display
    @@display_method.display_cart(self)
  end

  def calculate_total_without_discount
    sum = 0
    @items.each do |product, count|
      sum += (count * product.price)
    end
    # Don't round yet in case it impacts the discount
    sum
  end

  class Total
    attr_reader :discount, :total

    def initialize(cart)
      @total_without_discount = cart.calculate_total_without_discount
      @discount = Discount.find_discount(@total_without_discount, cart)
      @total = (@total_without_discount - @discount.value(@total_without_discount, cart)).round(2)
    end
  end
end
