Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'
  resources :product_categories, only: [:index, :new, :create]
  resources :products, only: [:index, :show, :new, :create, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
    end
  end  
end
