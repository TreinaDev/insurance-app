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
    post 'deactivate_token', on: :member
    post 'activate_token', on: :member
  end

  resources :product_categories, only: [:index, :new, :create, :show]
  resources :packages, only: [:index, :new, :create, :show] do
    resources :coverage_pricings, only: [:create]
    resources :service_pricings, only: [:create]
    post 'activate', on: :member
  end
  resources :pending_packages, only: [:index, :new, :create]
  resources :services, only: [:index, :new, :create, :show] do
    post 'deactivate', on: :member
    post 'activate', on: :member
  end
  resources :package_coverages, only: [:index, :new, :create, :show] do
    post 'deactivate', on: :member
    post 'activate', on: :member
  end
  
  resources :policies, only: [:index, :show, :update] do
    post 'disapproved', on: :member
    post 'approved', on: :member
    post 'canceled', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show] do
        get 'packages', on: :member
        resources :packages, only: [:show]
        get 'query', on: :collection
      end
      resources :insurance_companies, only: [:index, :show] do
        get 'query', on: :collection
      end
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
        post 'canceled', on: :member
      end
    end
  end
end
