Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  resources :users, except: :destroy
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  resources :order_products
  resources :orders
  resources :carts, only: %i(index create)

  resources :products, only: %i(index show)
  resources :products do
    resources :images, only: %i(create destroy)
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: :edit

  resources :password_resets, except: %i(index show destroy)

  namespace :admin do
    resources :products, except: %i(index show)
    resources :users, only: :destroy
  end
end
