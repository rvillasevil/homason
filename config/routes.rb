Rails.application.routes.draw do
  root "home#index"

  resource :dashboard, only: :show, controller: :dashboards, as: :dashboard
end
