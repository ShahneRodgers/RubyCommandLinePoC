# frozen_string_literal: false

class TextOutput
  def display_product(product)
    "#{product.name} ($#{product.price})"
  end

  def display_cart(cart)
    total = cart.calculate_total
    res = "Items:\n\n"
    cart.items.each do |product, amount|
      res << "#{amount} x #{product}\n"
    end
    res << "\nDiscount applied: #{total.discount}\n\nTOTAL: $#{total.total}"
  end
end
