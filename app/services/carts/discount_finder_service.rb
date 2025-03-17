module Carts
  class DiscountFinderService
    def initialize(product, quantity)
      @product = product
      @quantity = quantity
    end

    def call
      @product
        .discounts.where("min_quantity <= ?", @quantity)
        .select { |d| d.min_quantity <= @quantity && (d.max_quantity.nil? || d.max_quantity >= @quantity) }
        .max_by(&:percentage)
    end
  end
end
