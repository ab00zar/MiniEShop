RSpec.describe Carts::QueryParser do
  describe '#parse' do
    let(:subject) { described_class.new(query).parse }

    context 'with queries in a good format' do
      let(:query) { '2 ITEM,  3 ANOTHER ' }

      it 'handles the whitespaces' do
        expect(subject).to eq([[2, 'ITEM'], [3, 'ANOTHER']])
      end

      it 'converts the quantity to integer' do
        expect(subject.first.first.is_a?(Integer)).to be_truthy
      end
    end

    context 'with malformed queries' do
      context 'when the desired format is not followed' do
        let(:query) { 'A UUY 2' }
        let(:parser) { described_class.new(query).parse }

        it 'raise an error' do
          expect { parser }.to raise_error(ArgumentError, "Invalid item format: 'A UUY 2'")
        end
      end
    end
  end
end
