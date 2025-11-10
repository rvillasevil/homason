module Professionals
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action -> { require_role!("professional") }

    layout "dashboard"

    def show
      @profile = current_user.professional_profile
      if @profile.present?
        @bookings = @profile.bookings.includes(:customer, :material_order).order(date: :asc)
        @leads = @profile.leads.order(updated_at: :desc)
        @upcoming_follow_ups = @profile.leads.pending_follow_up.limit(10)
      else
        @bookings = Booking.none
        @leads = Lead.none
        @upcoming_follow_ups = Lead.none
      end
    end
  end
end
