class ProfessionalProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    profiles = ProfessionalProfile.where(verified: true).includes(:user)
    render json: profiles.as_json(include: { user: { only: [:name] } })
  end

  def show
    profile = ProfessionalProfile.find(params[:id])
    render json: profile.as_json(include: { user: { only: [:name] } })
  end

  def create
    require_role!("professional", "admin")

    profile = ProfessionalProfile.new(profile_params.merge(user_id: current_user.id, verified: false))
    if profile.save
      render json: profile, status: :created
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    profile = ProfessionalProfile.find(params[:id])
    unless current_user.admin? || profile.user_id == current_user.id
      return render json: { error: "Forbidden" }, status: :forbidden
    end

    if profile.update(profile_params)
      render json: profile
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:professional_profile).permit(:bio, :years_experience, :zone, :day_rate, :verified)
  end
end
