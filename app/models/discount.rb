class Discount < ApplicationRecord
  belongs_to :product

  enum :discount_type, { percentage: 0, volume: 1 }

  validates :min_quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :max_quantity, numericality: { only_integer: true }, allow_nil: true
  validates :percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
