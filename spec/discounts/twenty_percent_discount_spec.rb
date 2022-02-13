# frozen_string_literal: true

require 'test_helper'
require_relative '../../lib/discounts/twenty_percent_discount'

RSpec.describe Discount do
  context 'applies?' do
    it 'applies to values over $100' do
      expect(TwentyPercentDiscount.applies?(100.01, instance_double('Cart'))).to be(true)
    end

    it 'does not apply to $100 totals' do
      expect(TwentyPercentDiscount.applies?(100, instance_double('Cart'))).to be(false)
    end

    it 'does not apply to <$100 totals' do
      expect(TwentyPercentDiscount.applies?(0, instance_double('Cart'))).to be(false)
    end
  end

  context 'value' do
    it 'is $22 for $110 values' do
      expect(TwentyPercentDiscount.value(110, instance_double('Cart'))).to eq(22)
    end

    it 'is $20.002 for $100.01 values' do
      expect(TwentyPercentDiscount.value(100.01, instance_double('Cart'))).to be_within(0.1).of(20.002)
    end
  end
end
