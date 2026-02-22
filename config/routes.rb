Rails.application.routes.draw do
  root "products#index"

  devise_for :users
  resources :products
  resources :chats, only: [:index]
  resources :messages, only: [:create]

  resources :wishlists do
    post :move_to_cart, on: :member
  end

  resource :cart, only: [:show] do
    post "add/:product_id", to: "carts#add", as: :add_to
    post :increase
    post :decrease
    delete "remove/:product_id", to: "carts#remove", as: :remove_from
  end

  resources :orders, only: [:index, :show, :create] do
    collection do
      get :success
      get :cancel
    end

    member do
      get :checkout
    end
  end

  post "buy_now/:product_id", to: "orders#buy_now", as: :buy_now
  post "/webhooks/stripe", to: "webhooks#stripe"

  mount ActionCable.server => "/cable"

  ActiveAdmin.routes(self)

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  get "up", to: "rails/health#show", as: :rails_health_check
end