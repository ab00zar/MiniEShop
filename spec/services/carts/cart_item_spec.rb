RSpec.describe Carts::CartItem do
  describe 'attributes' do
    it 'stores code, quantity, unit_price, and discount_percentage' do
      item = Carts::CartItem.new('A', 3, 10.0, 10.0)
      expect(item.code).to eq('A')
      expect(item.quantity).to eq(3)
      expect(item.unit_price).to eq(10.0)
      expect(item.discount_percentage).to eq(10.0)
    end
  end

  describe '#subtotal' do
    it 'calculates the subtotal' do
      item = Carts::CartItem.new('A', 3, 10.0, 0)
      expect(item.subtotal).to eq(30.0)
    end
  end

  describe '#discount_amount' do
    it 'calculates the discount amount' do
      item = Carts::CartItem.new('A', 3, 10.0, 10.0)
      expect(item.discount_amount).to eq(3.0)
    end

    it 'handles zero discount percentage' do
      item = Carts::CartItem.new('A', 3, 10.0, 0)
      expect(item.discount_amount).to eq(0.0)
    end
  end

  describe '#total' do
    it 'calculates the total' do
      item = Carts::CartItem.new('A', 3, 10.0, 10.0)
      expect(item.total).to eq(27.0)
    end

    it 'handles zero discount percentage' do
      item = Carts::CartItem.new('A', 3, 10.0, 0)
      expect(item.total).to eq(30.0)
    end
  end
end
