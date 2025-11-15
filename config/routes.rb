Rails.application.routes.draw do
  root "home#index"

  resource :session, only: %i[new create destroy]
  resource :profile, only: %i[show update]
  resource :dashboard, only: :show, controller: :dashboards, as: :dashboard
  resources :users, only: %i[new create]
end
