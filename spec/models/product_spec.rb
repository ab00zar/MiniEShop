RSpec.describe Product, type: :model do
  describe 'associations' do
    it 'has many discounts' do
      product = Product.new(code: 'P001', name: 'Test Product', price: 10.0)
      discount1 = Discount.new(min_quantity: 1, percentage: 10.0)
      discount2 = Discount.new(min_quantity: 5, percentage: 20.0)

      product.discounts << discount1
      product.discounts << discount2

      expect(product.discounts.size).to eq(2)
      expect(product.discounts).to include(discount1, discount2)
    end

    describe 'validations' do
      context 'with valid attributes' do
        it 'is valid' do
          product = Product.new(code: 'P001', name: 'Test Product', price: 10.0)
          expect(product).to be_valid
        end
      end
    end
  end
end
