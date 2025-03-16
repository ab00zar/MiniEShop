class Product < ApplicationRecord
  has_many :discounts

  VALID_CODE_FORMAT = /\A[A-Z0-9]+\z/

  validates :code, presence: true,
            uniqueness: true,
            format: { with: VALID_CODE_FORMAT, message: "Must contain only uppercase letters and numbers!" }
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
