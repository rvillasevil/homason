class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update]
  before_action :authorize_booking_access!, only: [:show, :update]

  def index
    bookings = case current_user.role
               when "admin"
                 Booking.all
               when "professional"
                 Booking.where(professional_profile_id: current_user.professional_profile_id)
               else
                 current_user.bookings
               end

    render json: bookings
  end

  def show
    render json: @booking
  end

  def create
    require_role!("customer", "admin")

    booking = current_user.bookings.new(booking_params)
    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(update_booking_params)
      render json: @booking
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def authorize_booking_access!
    return if current_user.admin?
    return if @booking.customer_id == current_user.id
    return if current_user.professional? && current_user.professional_profile_id == @booking.professional_profile_id

    render json: { error: "Forbidden" }, status: :forbidden
  end

  def booking_params
    params.require(:booking).permit(:professional_profile_id, :date, :days, :address, :description, :subscription_id)
  end

  def update_booking_params
    booking_params.merge(params.require(:booking).permit(:status))
  end
end