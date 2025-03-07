module Carts
  class TotalPriceCalculator
    def initialize(query_parser: Carts::QueryParser)
      @query_parser = query_parser
    end

    def call(query)
      items = @query_parser.parse(query)
      calculate_total(items)
    end

    private

    def calculate_total(items)
      total = 0
      items.each do |quantity, code|
        product = Product.find_by(code: code)
        total += quantity * product.price
      end
      total
    end
  end
end
