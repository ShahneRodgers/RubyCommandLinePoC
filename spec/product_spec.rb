# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/product'

RSpec.describe Product do
  context 'valid creation' do
    let(:product) { Product.create(1, 'Name', 5.30) }

    it 'sets the uuid' do
      expect(product.uuid).to eq(1)
    end

    it 'sets the name' do
      expect(product.name).to eq('Name')
    end

    it 'sets the price' do
      expect(product.price).to eq(5.3)
    end
  end

  context 'invalid creation' do
    it 'cannot be created directly' do
      expect { Product.new(1, 'Name', 5.3) }.to raise_error(NoMethodError)
    end

    it 'requires the uuid to be a number' do
      expect { Product.create('x', 'Name', 5.3) }.to raise_error(/uuid/)
    end

    it 'requires the name to be non-null' do
      expect { Product.create(1, nil, 5.3) }.to raise_error(/name/)
    end

    it 'requires the name to be not empty' do
      expect { Product.create(1, '', 5.3) }.to raise_error(/name/)
    end

    it 'requires the price to be a number' do
      expect { Product.create(1, 'Name', 'x') }.to raise_error(/price/)
    end

    it 'prevents a negative price' do
      expect { Product.create(1, 'Name', -3) }.to raise_error(/price/)
    end

    it 'prevents free items' do
      expect { Product.create(1, 'Name', 0) }.to raise_error(/price/)
    end
  end
end
