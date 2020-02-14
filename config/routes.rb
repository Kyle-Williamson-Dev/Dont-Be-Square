Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  resources :events, only: [:new, :create, :show, :update, :destroy]
end
