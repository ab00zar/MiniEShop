RSpec.describe 'Carts API', type: :request do
  describe 'GET /api/v1/carts/total_price' do
    let(:calculator_double) { instance_double(Carts::TotalPriceCalculator) }
    let(:query_params) { { items: '1 MUG, 2 TSHIRT' } }
    let(:total_price_result) { { 'total' => 26.0 } }

    before do
      allow(Carts::TotalPriceCalculator).to receive(:new).and_return(calculator_double)
      allow(calculator_double).to receive(:call).and_return(total_price_result)
    end

    it 'returns the total price' do
      get '/api/v1/carts/total_price', params: query_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(total_price_result)
    end

    it 'calls the TotalPriceCalculator with the correct parameters' do
      get '/api/v1/carts/total_price', params: query_params

      expect(Carts::TotalPriceCalculator).to have_received(:new).with(query: query_params[:items])
      expect(calculator_double).to have_received(:call)
    end

    context 'when TotalPriceCalculator raises an error' do
      before do
        allow(calculator_double).to receive(:call).and_raise(ArgumentError, 'Invalid query')
      end

      it 'returns a bad request error' do
        get '/api/v1/carts/total_price', params: query_params

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include('error')
      end
    end

    context 'when TotalPriceCalculator raises a standard error' do
      before do
        allow(calculator_double).to receive(:call).and_raise(StandardError, 'Something went wrong')
      end

      it 'returns an internal server error' do
        get '/api/v1/carts/total_price', params: query_params

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to include('error')
      end
    end

    context 'when params[:items] is missing' do
      it 'returns a bad request error' do
        get '/api/v1/carts/total_price', params: {}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
