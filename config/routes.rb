Rails.application.routes.draw do
  root to: "sessions#new"
  resources :sessions, only: [:new, :create, :destroy]
  resources :parts, only: [:index, :edit, :update]
  resources :users, only: [:new, :create]
  resources :warehouses, only: [:new, :create] do
    resources :parts, only: [:index, :destroy] do
      member do
        get 'use'
      end
    end
  end
  resources :orders, only: [:index, :create, :new, :show, :update]


end
