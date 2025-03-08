module Carts
  class TotalPriceCalculator
    def initialize(query_parser: Carts::QueryParser, discount_finder: Carts::DiscountFinderService)
      @query_parser = query_parser
      @discount_finder = discount_finder
    end

    def call(query)
      items = @query_parser.parse(query)
      calculate_total(items)
    end

    private

    def calculate_total(items)
      total = 0
      items.each do |quantity, code|6
        product = Product.find_by(code: code)
        discount = @discount_finder.new(product, quantity).call
        sub_total = quantity * product.price
        discount.present? ? total += sub_total * (1- discount.percentage / 100).round(2) : total += sub_total
      end
      total
    end
  end
end
