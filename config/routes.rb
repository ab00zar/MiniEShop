Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :update], param: :code do
        collection do
          put '/', to: 'products#update' # needed to use code as param
        end
      end
    end
  end
end
