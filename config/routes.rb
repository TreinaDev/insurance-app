Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index, :show, :new, :create, :edit, :update] do
    post 'deactivate', on: :member
    post 'activate', on: :member
  end
  
  resources :product_categories, only: [:index, :new, :create]
  resources :insurance_companies, only: [:index, :show, :new, :create, :edit, :update]   
  resources :packages, only: [:index]
  resources :pending_packages, only: [:index, :new, :create]
  resources :package_coverages, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
      resources :insurance_companies, only: [:index, :show]
      resources :packages, only: [:index]
    end
  end
end
