Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :update], param: :code do
        collection do
          put '/', to: 'products#update'
        end
      end

      get '/carts/total_price', to: 'carts#total_price'
    end
  end
end
