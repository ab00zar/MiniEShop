RSpec.describe Carts::CartItemFactory do
  describe '#call' do
    let(:query) { [[2, 'A'], [3, 'B']] }
    let(:product_a) { instance_double(Product, code: 'A', price: 10.0, discounts: []) }
    let(:product_b) { instance_double(Product, code: 'B', price: 20.0, discounts: []) }
    let(:discount_a) { instance_double(Discount, percentage: 5.0) }
    let(:discount_b) { nil }
    let(:cart_item_class) { class_double(Carts::CartItem) }
    let(:cart_item_a) { instance_double(Carts::CartItem) }
    let(:cart_item_b) { instance_double(Carts::CartItem) }
    let(:product_finder) { double('product_finder') }
    let(:discount_finder) { double('discount_finder') }

    let(:factory) do
      described_class.new(
        query,
        product_finder: product_finder,
        discount_finder: discount_finder,
        cart_item: cart_item_class
      )
    end

    before do
      allow(product_finder).to receive(:where).with(code: ['A', 'B']).and_return(
        double(includes: double(index_by: { 'A' => product_a, 'B' => product_b }))
      )
      allow(discount_finder).to receive(:new).with(product_a, 2).and_return(double(call: discount_a))
      allow(discount_finder).to receive(:new).with(product_b, 3).and_return(double(call: discount_b))
      allow(cart_item_class).to receive(:new).with('A', 2, 10.0, 5.0).and_return(cart_item_a)
      allow(cart_item_class).to receive(:new).with('B', 3, 20.0, 0).and_return(cart_item_b)
    end

    it 'builds cart items with correct attributes' do
      result = factory.call

      expect(result).to eq([cart_item_a, cart_item_b])
    end

    context 'when a product is not found' do
      let(:error) { 'Product code: C is NOT found!' }

      it 'raises an error' do
        allow(product_finder).to receive(:where).with(code: ['A', 'C']).and_return(
          double(includes: double(index_by: { 'A' => product_a }))
        )
        query_with_missing_product = [[2, 'A'], [3, 'C']]
        factory_with_missing_product = described_class.new(
          query_with_missing_product,
          product_finder: product_finder,
          discount_finder: discount_finder,
          cart_item: cart_item_class
        )

        expect { factory_with_missing_product.call }.to raise_error(StandardError, error)
      end
    end

    context 'when discount is present' do
      it 'passes the discount percentage to the cart item' do
        factory.call
        expect(cart_item_class).to have_received(:new).with('A', 2, 10.0, 5.0)
      end
    end

    context 'when discount is nil' do
      it 'passes 0 as the discount percentage to the cart item' do
        factory.call
        expect(cart_item_class).to have_received(:new).with('B', 3, 20.0, 0)
      end
    end

    context 'when product finder returns empty hash' do
      it 'raises error for each not found product' do
        allow(product_finder).to receive(:where).with(code: ['C', 'D']).and_return(
          double(includes: double(index_by: {}))
        )
        query_with_missing_product = [[1, 'C'], [1, 'D']]
        factory_with_missing_product = described_class.new(
          query_with_missing_product,
          product_finder: product_finder,
          discount_finder: discount_finder,
          cart_item: cart_item_class
        )

        expect { factory_with_missing_product.call }.to raise_error(StandardError, "Product code: C is NOT found!")
      end
    end
  end
end
