### Overview

A simple commandline PoC that reads products in from a JSON file, allows the user to view these and add them to a cart and then view the total in the cart. Discounts will be automatically applied based on the cart's total.

### Running

Assuming you have Ruby installed and are in this directory, you should simply be able to run:

```bash
bundle install
ruby lib/main.rb
```

### Development

Tests can be run using `rspec` and the code should be formatted using `rubocop -a`

### Features that may be bugs

* Unfortunately there's currently no way to add multiple of a product in one step; instead you must add them one at a time. Eg, if you wanted two apples, you'd need to view products, add an apple to your cart, view products and add another apple to your cart. Likewise with removing.
* The discounts may put your cart value below the value at which you get the discount. Eg, if you have your cart's value at $101, you'll get the 20% discount (due to the cart being >$100) which will put the cart below $100. It's unclear whether this is desired.