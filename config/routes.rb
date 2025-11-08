Rails.application.routes.draw do
  post "signup", to: "auth#signup"
  post "login",  to: "auth#login"

  resources :professional_profiles, only: [:index, :create, :update, :show]
  resources :bookings, only: [:index, :create, :update, :show]
  resources :material_orders, only: [:create, :show]
  resources :subscription_plans, only: [:index]
  resources :subscriptions, only: [:index, :create, :update]
  resources :reviews, only: [:create]
end