Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'

  namespace :panel do
    namespace :v1, as: :v1 do
      root 'home#index'

      resources :municipes, except: [:destroy] do
        get 'search_zip_code', to: 'municipe_addresses#search_zip_code'
        resources :municipe_addresses, except: [:destroy]
      end
    end
  end
end
