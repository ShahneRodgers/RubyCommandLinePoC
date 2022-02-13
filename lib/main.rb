# frozen_string_literal: true

require 'tty-prompt'
require_relative 'cart'
require_relative 'input/json_reader'

class Mediator
  def initialize(product_fetcher)
    @products = product_fetcher.product_list
    @prompt = TTY::Prompt.new
    @cart = Cart.new
  end

  def run_loop
    loop do
      actions = { 'Display/purchase products' => method(:display_products),
                  'Display cart' => method(:display_cart), 'Edit cart' => method(:edit_cart), 'Quit' => method(:exit) }
      @prompt.select('What would you like?', actions).call
    end
  end

  def display_products
    @prompt.multi_select('Purchase products?', @products).each do |item|
      @cart.add_product(item)
    end
  end

  def display_cart
    puts @cart.display
  end

  def edit_cart
    return cannot_edit if @cart.items.keys.empty?

    @prompt.multi_select('Remove items from cart', @cart.items.keys).each do |item|
      @cart.remove_product(item)
    end
  end

  def cannot_edit
    puts "Your cart is empty - there's nothing to edit!"
  end
end

json_file_reader = JsonReader.from_file(File.expand_path('products.json', "#{__dir__}/.."))
Mediator.new(json_file_reader).run_loop
