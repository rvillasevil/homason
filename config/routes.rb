Rails.application.routes.draw do
  root "home#index"

  post "signup", to: "auth#signup"
  post "login",  to: "auth#login"

  resources :users, only: [:index, :show, :update] do
    collection do
      get :me
    end
  end

  resources :professional_profiles, only: [:index, :create, :update, :show]
  resources :bookings, only: [:index, :create, :update, :show]
  resources :material_orders, only: [:create, :show]
  resources :subscription_plans, only: [:index]
  resources :subscriptions, only: [:index, :create, :update]
  resources :reviews, only: [:create]
  resources :leads

  namespace :professionals do
    get "login", to: "sessions#new"
    get "signup", to: "registrations#new"
    resource :dashboard, only: :show
  end

  namespace :clients do
    get "login", to: "sessions#new"
    get "signup", to: "registrations#new"
    resource :dashboard, only: :show
  end
end
