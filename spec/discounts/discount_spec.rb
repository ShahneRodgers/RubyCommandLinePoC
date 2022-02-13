# frozen_string_literal: true

require 'test_helper'
require_relative '../../lib/discounts/discount'
require_relative '../../lib/cart'

RSpec.describe Discount do
  context 'finding matching discount' do
    it 'returns the first matching discount' do
      stub = setup_discount_stub(true)
      Discount.class_variable_set(:@@discounts, [setup_discount_stub(false), stub])
      expect(Discount.find_discount(20, instance_double('Cart'))).to eq(stub)
    end

    it 'ignores subsequent matching discounts' do
      first_match = setup_discount_stub(true)
      Discount.class_variable_set(:@@discounts, [first_match, setup_discount_stub(true)])
      expect(Discount.find_discount(20, instance_double('Cart'))).to eq(first_match)
    end

    it 'returns NoDiscount class if nothing matches' do
      Discount.class_variable_set(:@@discounts, [setup_discount_stub(false)])
      expect(Discount.find_discount(200, instance_double('Cart'))).to be(NoDiscount)
    end

    def setup_discount_stub(is_match)
      class_double('Discount_name', applies?: is_match)
    end
  end

  context 'no matching discount' do
    it 'always applies' do
      expect(NoDiscount.applies?(nil, nil)).to be(true)
    end

    it 'has a value of 0' do
      expect(NoDiscount.value(nil, nil)).to be(0)
    end
  end
end
