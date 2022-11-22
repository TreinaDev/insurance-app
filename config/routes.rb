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
  
  resources :product_categories, only: [:index, :new, :create, :show]
  resources :insurance_companies, only: [:index, :show, :new, :create, :edit, :update]   
  resources :packages, only: [:index, :new, :create, :show] do
    resources :coverage_pricings, only: [:create]
  end
  resources :pending_packages, only: [:index, :new, :create]
  resources :services, only: [:index, :new, :create]
  resources :package_coverages, only: [:index, :new, :create]
  
  resources :policies, only: [:index, :show] do
    post 'disapproved', on: :member
    post 'approved', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
      resources :insurance_companies, only: [:index, :show]
      resources :packages, only: [:index, :show]
      resources :package_coverages, only: [:index]
      resources :services, only: [:index]
      resources :product_categories, only: [:index] do
        get 'products', on: :member
      end
      resources :policies, only: [:show, :create], param: :code do
        get 'equipment/:equipment_id', to: 'policies#equipment', on: :collection
        get 'order/:order_id', to: 'policies#order', on: :collection 
        post 'active', on: :member
      end
    end
  end
end
