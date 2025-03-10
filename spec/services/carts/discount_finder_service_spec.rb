RSpec.describe Carts::DiscountFinderService do
  describe '#call' do
    let(:product) { Product.create(code: 'Test', name: 'Test Product', price: 99.99) }
    let(:quantity) { 5 }
    let(:service) { described_class.new(product, quantity) }

    context 'when no matching discount found' do
      it 'returns nil' do
        expect(service.call).to be_nil
      end

      context 'when there is no available discount on that product' do
        let(:other_product) { Product.create!(name: "Other Product", price: 10.0)}
        let(:discount) { other_product.discounts.create!(min_quantity: 1, max_quantity: 10, percentage: 10.0)}
        it { expect(service.call).to be_nil }
      end

      context 'when the quantity is less than min quantity required' do
        let(:discount) { product.discounts.create(min_quantity: 20, percentage: 20, discount_type: 0) }
        it 'returns nil' do
          expect(service.call).to be_nil
        end
      end
    end

    context 'when matching discount found' do
      let!(:discount) { product.discounts.create(discount_type: 0, min_quantity: 5, max_quantity: 10, percentage: 20) }

      context 'when product quantity is between min & max quantities of discount' do
        it { expect(service.call).to eq(discount) }
      end

      context 'when max_quantity is nil' do
        let!(:discount) { Discount.create(product: product, min_quantity: 3, max_quantity: nil, percentage: 10.0) }

        it 'returns the matching discount' do
          expect(service.call).to eq(discount)
        end
      end

      context 'when multiple discounts exist' do
        let(:quantity) { 26 }
        let!(:discount1) { Discount.create(product: product, min_quantity: 15, max_quantity: 30, percentage: 5.0) }
        let!(:discount2) { Discount.create(product: product, min_quantity: 25, max_quantity: 35, percentage: 10.0) }

        it 'returns the first matching discount' do
          expect(service.call).to eq(discount2)
        end
      end
    end
  end
end
