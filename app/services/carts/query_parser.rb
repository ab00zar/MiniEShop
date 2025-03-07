module Carts
  class QueryParser
    def self.parse(query)
      query
        .split(',')
        .map { |pair| pair.split(' ') }
        .map { |quantity, code| [quantity.to_i, code] }
    end
  end
end
