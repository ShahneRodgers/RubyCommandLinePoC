# frozen_string_literal: true

require 'test_helper'
require_relative '../../lib/discounts/fifteen_percent_discount'

RSpec.describe Discount do
  context 'applies?' do
    it 'applies to values over $50' do
      expect(FifteenPercentDiscount.applies?(50.01, instance_double('Cart'))).to be(true)
    end

    it 'does not apply to $50 totals' do
      expect(FifteenPercentDiscount.applies?(50, instance_double('Cart'))).to be(false)
    end

    it 'does not apply to <$20 totals' do
      expect(FifteenPercentDiscount.applies?(0, instance_double('Cart'))).to be(false)
    end
  end

  context 'value' do
    it 'is $9 for $60 values' do
      expect(FifteenPercentDiscount.value(60, instance_double('Cart'))).to eq(9)
    end

    it 'is $7.5165 for $50.11 values' do
      expect(FifteenPercentDiscount.value(50.11, instance_double('Cart'))).to be_within(0.1).of(7.5165)
    end
  end
end
