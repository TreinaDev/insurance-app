Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index]

  resources :product_categories, only: [:index, :new, :create]
end
