module Carts
  class DiscountFinderService
    def initialize(product, quantity)
      @product = product
      @quantity = quantity
    end

    def call
      @product
        .discounts.where("min_quantity <= ?", @quantity)
        .where("max_quantity >= ? OR max_quantity IS NULL", @quantity)
        .first
    end
  end
end
