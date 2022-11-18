Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index, :show, :new, :create, :edit, :update] do
    post 'deactivate', on: :member
    post 'activate', on: :member
  end
  
  resources :insurance_companies, only: [:index, :show, :new, :create, :edit, :update] do
    post 'deactivate', on: :member
    post 'activate', on: :member
  end
  
  resources :product_categories, only: [:index, :new, :create]
  resources :packages, only: [:index, :new, :create]
  resources :pending_packages, only: [:index, :new, :create]
  resources :services, only: [:index, :new, :create]
  resources :package_coverages, only: [:index, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
      resources :insurance_companies, only: [:index, :show]
      resources :packages, only: [:index, :show]
      resources :package_coverages, only: [:index]
      resources :services, only: [:index]
      resources :policies, only: [:index, :show, :create]
      resources :product_categories, only: [:index] do
        get 'products', on: :member
      end
    end
  end
end
