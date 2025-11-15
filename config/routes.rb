Rails.application.routes.draw do
  root "home#index"

  resource :session, only: %i[new create destroy]
  resource :profile, only: %i[show update], controller: :profiles
  resource :dashboard, only: :show, controller: :dashboards, as: :dashboard
end
