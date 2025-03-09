module Carts
  class TotalPriceCalculator
    def initialize(
      query:,
      query_parser: Carts::QueryParser,
      cart_item_builder: Carts::CartItemFactory,
      price_explanation_factory: PriceExplanationPresenter
    )
      @query = query
      @query_parser = query_parser
      @cart_item_builder = cart_item_builder
      @price_explanation_factory = price_explanation_factory
    end

    def call
      parsed_query = @query_parser.new(@query).parse
      items = @cart_item_builder.new(parsed_query).call
      @price_explanation_factory.new(items).call
    end
  end
end
