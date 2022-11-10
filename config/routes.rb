Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index, :show, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
      resources :packages, only: [:index]
    end
  end
end
