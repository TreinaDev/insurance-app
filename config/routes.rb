Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :insurance_companies, only: [:index]
  resources :product_categories, only: [:index]
  resources :products, only: [:index]
  resources :coverages, only: [:index]
  resources :services, only: [:index]
end
