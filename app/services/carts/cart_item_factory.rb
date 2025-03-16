module Carts
  class CartItemFactory
    def initialize(
      query,
      product_finder: Product,
      discount_finder: Carts::DiscountFinderService,
      cart_item: Carts::CartItem
    )
      @query = query
      @product_finder = product_finder
      @discount_finder = discount_finder
      @cart_item = cart_item
    end

    def call
      product_codes = @query.map { |_, code| code }
      products = @product_finder.where(code: product_codes).includes(:discounts).index_by(&:code)

      @query.map do |quantity, code|
        build_cart_items(quantity, code, products)
      end.compact
    end

    private

    def build_cart_items(quantity, code, products)
      product = products[code]
      raise ActiveRecord::RecordNotFound, "Product code: #{code} is NOT found!" unless product

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
