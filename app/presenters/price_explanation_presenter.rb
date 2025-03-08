class PriceExplanationPresenter

  def initialize(items)
    @items = items
  end

  def call
    {
      'Total': total_price,
      'Explanation:': {
        'Total without discount': total_without_discount_explanation,
        'Discount': discount_explanation,
        'Total': total_explanation
      }
    }
  end

  private

  def total_without_discount_explanation
    "#{@items.map(&:subtotal).join(' + ')} = #{total_without_discount}"
  end

  def total_without_discount
    @total_without_discount ||= @items.sum(&:subtotal)
  end

  def discount_items
    @discount_items ||= @items.select { |item| item.discount_percentage > 0 }
  end

  def total_discount
    @total_discount ||= @items.sum(&:discount_amount)
  end

  def discount_explanation
    discount_items.empty? ? "0" : "#{format_discount_items} = #{total_discount}"
  end

  def format_discount_items
    discount_items.map do |item|
      "#{item.discount_amount} (#{item.discount_percentage}% discount on #{item.code})"
    end.join(' + ')
  end

  def total_explanation
    "#{total_without_discount} - #{total_discount} = #{total_price}"
  end

  def total_price
    @total_price ||= total_without_discount - total_discount
  end
end
