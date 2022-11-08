Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index, :show, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :insurance_companies, only: [:index]
    end
  end
end
