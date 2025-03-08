module Api::V1
  class CartsController < ApplicationController
    def total_price
      total = Carts::TotalPriceCalculator.new.call(params[:items])
      render json: total
    rescue StandardError => e
      render json: { error: 'something happened!' }
    end
  end
end
