Rails.application.routes.draw do
  devise_for :users
  root to: 'home#welcome'

  resources :products, only: [:index, :show]

end
