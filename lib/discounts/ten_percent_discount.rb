# frozen_string_literal: true

class TenPercentDiscount
  def self.applies?(subtotal, _cart)
    subtotal > 20
  end

  def self.value(subtotal, _cart)
    0.1 * subtotal
  end

  def self.to_s
    '10% off on total greater than $20'
  end
end
