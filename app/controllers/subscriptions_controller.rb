class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.subscriptions
  end

  def create
    plan = SubscriptionPlan.active.find(params[:plan_id])

    sub = current_user.subscriptions.create!(
      subscription_plan: plan,
      active: true,
      started_at: Time.current,
      remaining_hours: plan.yearly_hours
    )

    # Aquí iría la integración con pagos (Stripe, etc.)

    render json: sub, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Plan inválido" }, status: :not_found
  end

  def update
    sub = current_user.subscriptions.active.find(params[:id])
    sub.update!(active: false, cancelled_at: Time.current)
    render json: sub
  rescue ActiveRecord::RecordNotFound
    render json: { error: "No hay suscripción activa" }, status: :not_found
  end
end
