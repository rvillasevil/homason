class MaterialOrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    booking = Booking.find(params[:booking_id])

    unless booking.customer_id == current_user.id || current_user.admin?
      return render json: { error: "Forbidden" }, status: :forbidden
    end

    items = params[:items] || []
    total = items.sum { |i| i[:quantity].to_i * i[:unit_price_cents].to_i }
    margin = (total * 0.10).to_i

    order = MaterialOrder.find_or_initialize_by(booking: booking)
    order.items_json = items.to_json
    order.total_cost_cents = total
    order.margin_cents = margin
    order.status = "pending"

    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    order = MaterialOrder.find(params[:id])
    render json: order
  end
end
