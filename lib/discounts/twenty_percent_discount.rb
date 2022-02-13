# frozen_string_literal: true

class TwentyPercentDiscount
  def self.applies?(subtotal, _cart)
    subtotal > 100
  end

  def self.value(subtotal, _cart)
    0.2 * subtotal
  end

  def self.to_s
    '20% off on total greater than $100'
  end
end
