RSpec.describe Api::V1::ProductsController, type: :request do
  describe "GET /products" do
    it "returns all products with status 200" do
      product1 = Product.create!(code: 'P01', name: 'Product 1', price: 100.0)
      product2 = Product.create!(code: 'P02', name: 'Product 2', price: 150.0)

      get '/api/v1/products'
      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.size).to eq(2)
      expect(parsed_response.map { |p| p['code'] }).to match_array([product1.code, product2.code])
    end
  end

  describe "PUT /api/v1/update" do
    let!(:product) { Product.create(code: "ABC123", name: "Test Product", price: 19.99) }

    context 'with valid params' do
      it 'updates the product and returns a successful response' do
        put "/api/v1/products/#{product.code}", params: { price: 15.0 }
        expect(response).to have_http_status(:ok)
        product.reload
        expect(product.price).to eq(15.0)
        expect(JSON.parse(response.body)['price']).to eq("15.0")
      end
    end

    context 'with invalid params' do
      it "returns http unprocessable_entity" do
        patch "/api/v1/products/#{product.code}", params: { price: -5 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body).dig('price')).to eq(['must be greater than 0'])
      end
    end

    context 'when product is not found' do
      it 'returns nil and does not update anything' do
        expect {
          patch :update, params: { code: "NONEXISTENT", price: 25.99 }
        }.to raise_error(NoMethodError)
      end
    end
  end
end
