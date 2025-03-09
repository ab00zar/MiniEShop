RSpec.describe Carts::TotalPriceCalculator do
  let(:query) { 'some query' }
  let(:parsed_query) { double('parsed_query') }
  let(:items) { double('items') }
  let(:price_explanation) { double('price_explanation') }
  let(:query_parser) { class_double(Carts::QueryParser) }
  let(:query_parser_instance) { instance_double(Carts::QueryParser, parse: parsed_query) }
  let(:cart_item_builder) { class_double(Carts::CartItemFactory) }
  let(:cart_item_instance) { instance_double(Carts::CartItemFactory, call: items) }
  let(:price_explanation_factory) { class_double(PriceExplanationPresenter) }
  let(:price_explanation_instance) { instance_double(PriceExplanationPresenter, call: price_explanation) }

  before do
    allow(query_parser).to receive(:new).with(query).and_return(query_parser_instance)
    allow(cart_item_builder).to receive(:new).with(parsed_query).and_return(cart_item_instance)
    allow(price_explanation_factory).to receive(:new).with(items).and_return(price_explanation_instance)
  end

  subject { described_class.new(query: query,
                                query_parser: query_parser,
                                cart_item_builder: cart_item_builder,
                                price_explanation_factory: price_explanation_factory) }

  describe '#call' do
    it 'parses the query' do
      expect(query_parser).to receive(:new).with(query)
      expect(query_parser_instance).to receive(:parse)
      subject.call
    end

    it 'builds cart items from the parsed query' do
      expect(cart_item_builder).to receive(:new).with(parsed_query)
      expect(cart_item_instance).to receive(:call)
      subject.call
    end

    it 'generates price explanation for the cart items' do
      expect(price_explanation_factory).to receive(:new).with(items)
      expect(price_explanation_instance).to receive(:call)
      subject.call
    end

    it 'returns the price explanation' do
      expect(subject.call).to eq(price_explanation)
    end
  end

  context 'with default dependencies' do
    subject { described_class.new(query: query) }

    it 'initializes with default dependencies' do
      expect { subject }.not_to raise_error
    end
  end
end
