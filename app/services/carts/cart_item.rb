module Carts
  CartItem = Struct.new(:code, :quantity, :unit_price, :discount_percentage) do
    def subtotal
      quantity * unit_price
    end

    def discount_amount
      subtotal * (discount_percentage / 100.0)
    end

    def total
      subtotal - discount_amount
    end
  end
end
