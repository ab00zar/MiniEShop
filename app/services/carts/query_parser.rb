module Carts
  class QueryParser
    ITEM_PATTERN = /^\d+ [A-Z0-9]+$/

    def initialize(query)
      @query = query
    end

    def parse
      validate_query
      items = @query.split(',').map(&:strip)
      items.each { |item| validate_item(item) }

      items
        .map { |pair| pair.split(' ') }
        .map { |quantity, code| [quantity.to_i, code] }
    end

    private

    def validate_query
      raise ArgumentError, "Query must be a string" unless @query.is_a?(String)
    end

    def validate_item(item)
      raise ArgumentError, "Invalid item format: '#{item}'" unless item.match?(ITEM_PATTERN)
    end
  end
end
