module Carts
  class CartItemFactory
    def initialize(
      query,
      product_finder: Product.method(:find_by),
      discount_finder: Carts::DiscountFinderService,
      cart_item: Carts::CartItem
    )
      @query = query
      @product_finder = product_finder
      @discount_finder = discount_finder
      @cart_item = cart_item
    end

    def call
      @query.map { |quantity, code| build_cart_items(quantity, code) }.compact
    end

    private

    def build_cart_items(quantity, code)
      product = @product_finder.call(code: code)
      return unless product

      discount = @discount_finder.new(product, quantity).call
      @cart_item.new(
        code,
        quantity,
        product.price,
        discount&.percentage || 0
      )
    end
  end
end
