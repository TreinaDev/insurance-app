Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'
  resources :product_categories, only: [:index, :new, :create]
  resources :products, only: [:index, :show, :new, :create]
end
