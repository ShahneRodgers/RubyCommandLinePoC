# frozen_string_literal: true

require 'test_helper'
require_relative '../../lib/discounts/ten_percent_discount'

RSpec.describe Discount do
  context 'applies?' do
    it 'applies to values over $20' do
      expect(TenPercentDiscount.applies?(20.10, instance_double('Cart'))).to be(true)
    end

    it 'does not apply to $20 totals' do
      expect(TenPercentDiscount.applies?(20, instance_double('Cart'))).to be(false)
    end

    it 'does not apply to <$20 totals' do
      expect(TenPercentDiscount.applies?(0, instance_double('Cart'))).to be(false)
    end
  end

  context 'value' do
    it 'is $3 for $30 values' do
      expect(TenPercentDiscount.value(30, instance_double('Cart'))).to eq(3)
    end

    it 'is $2.011 for $20.11 values' do
      expect(TenPercentDiscount.value(20.11, instance_double('Cart'))).to eq(2.011)
    end
  end
end
