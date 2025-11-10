module Clients
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action -> { require_role!("customer") }

    layout "dashboard"

    def show
      @bookings = current_user.bookings.includes(:professional_profile, :material_order).order(date: :desc)
      @upcoming_bookings = @bookings.where("date >= ?", Time.zone.now).order(date: :asc).limit(5)
      @leads = current_user.customer_leads.order(updated_at: :desc)
      @subscriptions = current_user.subscriptions.includes(:subscription_plan)
      @material_orders = MaterialOrder.where(booking_id: @bookings.select(:id)).includes(:booking)
    end
  end
end