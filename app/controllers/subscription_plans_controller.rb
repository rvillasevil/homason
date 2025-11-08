class SubscriptionPlansController < ApplicationController
  def index
    render json: SubscriptionPlan.active
  end
end