# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/cart'
require_relative '../lib/product'
require_relative '../lib/discounts/discount'

RSpec.describe Cart do
  let(:cart) { Cart.new }
  let(:product1) { Product.create(1, 'product1', 10) }
  let(:product2) { Product.create(2, 'product2', 20) }

  context 'Adding items' do
    it "changes the cart's items" do
      expect { cart.add_product(product1) }.to change(cart, :items)
    end

    it 'adds the new product' do
      cart.add_product(product1)
      expect(cart.items[product1]).to eq(1)
    end

    it 'increases the count for an existing product' do
      cart.add_product(product1)
      cart.add_product(product1)
      expect(cart.items[product1]).to eq(2)
    end

    it 'does not add another item' do
      cart.add_product(product1)
      expect(cart.items).not_to include(product2)
    end
  end

  context 'Removing items' do
    before(:each) do
      cart.items[product1] = 2
    end

    it 'decreases the product count' do
      cart.remove_product(product1)
      expect(cart.items[product1]).to eq(1)
    end

    it 'removes the product when its count reaches 0' do
      cart.remove_product(product1)
      cart.remove_product(product1)
      expect(cart.items).not_to include(product1)
    end

    it 'throws an error if the product is not in the cart' do
      expect { cart.remove_product(product2) }.to raise_error(/cannot have negative/)
    end
  end

  context 'Calculating total' do
    it 'is zero for an empty cart' do
      expect(cart.calculate_total.total).to be(0)
    end

    it "gives the product's price" do
      cart.items[product1] = 1
      expect(cart.calculate_total.total).to be(product1.price)
    end

    it "multiplies the product's price by product number" do
      allow(Discount).to receive(:find_discount) { class_double('NoDiscount', value: 0) }
      cart.items[instance_double('Product', price: 15.05)] = 2
      expect(cart.calculate_total.total).to be(30.10)
    end

    it 'applies the given discount' do
      allow(Discount).to receive(:find_discount) { class_double('NoDiscount', value: 31) }
      # Currently allows the discount to be greater than the value. Perhaps we don't trust the discounts and want to disallow that?
      expect(cart.calculate_total.total).to be(-31)
    end

    it 'rounds the result appropriately' do
      cart.items[instance_double('Product', price: 15.002)] = 1
      expect(cart.calculate_total.total).to be(15.00)
    end
  end
end
