Rails.application.routes.draw do
  root to: "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  resources :parts, only: [:index]
  resources :warehouses, only: [:new, :create] do
    resources :parts, only: [:index]
  end

  resources :orders, only: [:index, :create, :new, :show, :update]
  
end
