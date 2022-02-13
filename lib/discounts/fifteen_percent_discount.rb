# frozen_string_literal: true

class FifteenPercentDiscount
  def self.applies?(subtotal, _cart)
    subtotal > 50
  end

  def self.value(subtotal, _cart)
    0.15 * subtotal
  end

  def self.to_s
    '15% off on total greater than $50'
  end
end
