module Api::V1
  class ProductsController < ApplicationController
    def index
      @products = Product.all
      render json: @products, status: :ok
    end

    def update
      @product = Product.find_by(code: params[:code])
      if @product.update(price: params[:price])
        render json: @product, status: :ok
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end
end
