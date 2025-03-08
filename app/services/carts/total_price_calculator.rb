module Carts
  class TotalPriceCalculator
    def initialize(query_parser: Carts::QueryParser, discount_finder: Carts::DiscountFinderService)
      @query_parser = query_parser
      @discount_finder = discount_finder
    end

    def call(query)
      items = @query_parser.parse(query)
      PriceExplanationPresenter.new(calculate_total(items)).call
    end

    private

    def calculate_total(items)
      items.map do |quantity, code|
        product = Product.find_by(code: code)
        discount = @discount_finder.new(product, quantity).call
        [
          product.code,
          discount ? discount.percentage : '',
          total_without_discount(product, quantity),
          discounted_price(product, quantity, discount),
          total(product, quantity, discount)
        ]
      end
    end

    def total_without_discount(product, quantity)
      quantity * product.price
    end

    def discounted_price(product, quantity, discount)
      discount.present? ? product.price * quantity * (discount.percentage / 100) : 0
    end

    def total(product, quantity, discount)
      total_without_discount(product, quantity) - discounted_price(product, quantity, discount)
    end
  end
end
