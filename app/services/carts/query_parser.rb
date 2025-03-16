module Carts
  class QueryParser
    ITEM_PATTERN = /^\d+ [A-Z0-9]+$/

    def initialize(query)
      @query = query
    end

    def parse
      items.each { |item| validate_item(item) }

      items
        .map { |pair| pair.split(' ') }
        .map { |quantity, code| [quantity.to_i, code] }
    end

    private

    def items
      @query.split(',').map(&:strip)
    end

    def validate_item(item)
      raise ArgumentError, "Invalid item format: '#{item}'" unless item.match?(ITEM_PATTERN)
    end
  end
end
