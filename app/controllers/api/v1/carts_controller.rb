module Api::V1
  class CartsController < ApplicationController
    def total_price
      raise ArgumentError, "No item in the Cart!" if params[:items].blank?
      total = Carts::TotalPriceCalculator.new(query: params[:items]).call
      render json: total
    end
  end
end
