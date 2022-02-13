# frozen_string_literal: true

require_relative 'twenty_percent_discount'
require_relative 'fifteen_percent_discount'
require_relative 'ten_percent_discount'

class NoDiscount
  def self.applies?(_subtotal, _cart)
    true
  end

  def self.value(_subtotal, _cart)
    0
  end

  def self.to_s
    'None'
  end
end

class Discount
  @@discounts = [TwentyPercentDiscount, FifteenPercentDiscount, TenPercentDiscount]

  def self.find_discount(subtotal, cart)
    # Only return the first since this will be the max discount.
    # As requirements evolve, we may want to return all and choose by
    # top value or something else
    @@discounts.find { |discount| discount.applies?(subtotal, cart) } || NoDiscount
  end
end
