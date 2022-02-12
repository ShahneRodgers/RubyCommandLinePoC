# frozen_string_literal: true

require 'test_helper'
require_relative '../../lib/input/json_reader'
require_relative '../../lib/product'

RSpec.describe JsonReader do
  describe 'get product list' do
    context 'given an empty list' do
      it 'returns an empty list' do
        expect(JsonReader.new('[]').product_list).to eq([])
      end
    end

    context 'given a list of one product' do
      let(:products) do
        JsonReader.new('[{ "uuid": 1411, "name": "Jockey Wheels - Orange", "price": "15.39"}]').product_list
      end

      it 'should have one item' do
        expect(products.count).to eq(1)
      end

      it 'returns a product' do
        expect(products.first).to be_a(Product)
      end

      it 'sets the uuid' do
        expect(products.first.uuid).to eq(1411)
      end

      it 'sets the name' do
        expect(products.first.name).to eq('Jockey Wheels - Orange')
      end

      it 'sets the price' do
        expect(products.first.price).to eq(15.39)
      end
    end

    context 'given a list of multiple products' do
      let(:products) do
        JsonReader.new('[{
                    "uuid": 23881,
                    "name": "Chain Ring 146mm",
                    "price": "65.95"
                  },
                  {
                    "uuid": 13008,
                    "name": "Carbon Brake Pads",
                    "price": "92.00"
                  }]').product_list
      end

      it 'contains two products' do
        expect(products.count).to eq(2)
      end

      it "sets the first product's name" do
        expect(products.first.name).to eq('Chain Ring 146mm')
      end

      it "sets the second product's name" do
        expect(products[1].name).to eq('Carbon Brake Pads')
      end
    end

    context 'given invalid json' do
      it 'throws an error' do
        expect { JsonReader.new('[{invalid}]').product_list }.to raise_error(JSON::ParserError)
      end
    end

    context 'invalid product' do
      it 'throws an error' do
        expect { JsonReader.new('[{"uuid": 23881}]').product_list }.to raise_error(RuntimeError)
      end
    end
  end
end
