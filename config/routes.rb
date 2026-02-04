Rails.application.routes.draw do
  get "webhooks/stripe"
  get "cart/show"
  get "orders/index"
  get "orders/show"
  get "orders/create"
  get "products/index"
  get "products/show"
  get "products/new"
  get "products/create"
  get "products/edit"
  get "products/update"
  get "products/destroy"
  devise_for :users 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root 'products#index'


  resources :products, only: [:index, :show]

  resource :cart, only: [:show], controller: "cart" do
    post "add/:product_id", to: "cart#add", as: :add_to
    delete "remove/:product_id", to: "cart#remove", as: :remove_from
  end
  
  
  resources :orders, only: [:index, :show, :create]

  ActiveAdmin.routes(self)
  
  require "sidekiq/web"

  mount Sidekiq::Web => "/sidekiq"

  resources :payments, only: [] do
    collection do
      post :checkout
      get :success
      get :cancel
    end
  end
  

end
