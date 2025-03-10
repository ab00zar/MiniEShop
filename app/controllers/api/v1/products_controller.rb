module Api::V1
  class ProductsController < ApplicationController
    before_action :find_product, only: [:update]

    def index
      @products = Product.all
      render json: @products, status: :ok
    end

    def update
      if @product.update(price: params[:price])
        render json: @product, status: :ok
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end

    private

    def find_product
      @product = Product.find_by(code: params[:code])
      unless @product
        render json: { error: 'Product not found' }, status: :not_found
      end
    end

    def product_params
      params.permit(:price)
    end
  end
end
