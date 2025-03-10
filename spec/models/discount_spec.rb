RSpec.describe Discount, type: :model do
  describe 'associations' do
    it 'belongs to product' do
      product = Product.create!(code: 'P001', name: 'Test Product', price: 10.0)
      discount = Discount.new(product: product, min_quantity: 1, percentage: 10.0)
      expect(discount.product).to eq(product)
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        product = Product.create!(code: 'P001', name: 'Test Product', price: 10.0)
        discount = Discount.new(product: product, min_quantity: 1, percentage: 10.0)
        expect(discount).to be_valid
      end
    end
  end
end
