module Api::V1
  class CartsController < ApplicationController
    def total_price
      total = Carts::TotalPriceCalculator.new(query: params[:items]).call
      render json: total
    rescue StandardError => e
      render json: { error: 'something happened!' }
    end
  end
end
