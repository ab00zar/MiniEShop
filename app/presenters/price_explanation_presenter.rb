class PriceExplanationPresenter
  def initialize(data)
    @data = data
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
    "#{@data.map {|e| e[2]}.join(' + ')} = #{total_without_discount}"
  end

  def total_without_discount
    @data.map {|e| e[2]}.sum
  end

  def discount_info
    @discount_info ||= @data.map do |e|
      e[1].to_i > 0 ? [e[3], e[1], e[0]] : nil
    end.compact
  end

  def total_discount
    @total_discount ||= discount_info.sum { |e| e[0] }
  end

  def discount_explanation
    "#{discount_info.map {|discounted_price, percentage, code| "#{discounted_price} (#{percentage}% discount on #{code})"}.join(' + ') } = #{total_discount}"
  end

  def total_explanation
    "#{total_without_discount} - #{total_discount} = #{total_price}"
  end

  def total_price
    total_without_discount - total_discount
  end


end
