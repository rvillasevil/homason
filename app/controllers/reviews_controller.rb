class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    booking = Booking.find(params[:booking_id])

    unless booking.customer_id == current_user.id
      return render json: { error: "Forbidden" }, status: :forbidden
    end

    review = Review.new(
      rating: params[:rating],
      comment: params[:comment],
      booking: booking,
      customer: current_user,
      professional_profile_id: booking.professional_profile_id
    )

    if review.save
      update_professional_rating!(review)
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def update_professional_rating!(review)
    pro = review.professional_profile
    pro.rating_count += 1
    pro.rating_avg = ((pro.rating_avg * (pro.rating_count - 1)) + review.rating) / pro.rating_count
    pro.save!
  end
end
