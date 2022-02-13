# frozen_string_literal: true

require 'json'
require_relative '../product'

class JsonReader
  def initialize(input)
    @input = input
  end

  def product_list
    JSON.parse(@input).map do |product|
      Product.create(product['uuid'], product['name'], product['price'])
    end
  end

  def self.from_file(file_name)
    # Throw an error if the file doesn't exist / isn't readable
    JsonReader.new(File.read(file_name))
  end
end
