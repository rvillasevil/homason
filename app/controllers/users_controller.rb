class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]
  before_action :authorize_user_access!, only: [:show, :update]

  def index
    require_role!("admin")
    return if performed?

    users = User.all
    users = users.where(role: params[:role]) if params[:role].present?
    users = users.order(created_at: :desc)

    render json: users.select(:id, :name, :email, :role, :phone, :address, :created_at, :updated_at)
  end

  def show
    render json: @user.as_json(include: { professional_profile: {} })
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: current_user.as_json(include: { professional_profile: {} })
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user_access!
    return if current_user.admin? || current_user == @user

    render json: { error: "Forbidden" }, status: :forbidden
  end

  def user_params
    permitted = [:name, :email, :phone, :address, :password, :password_confirmation]
    permitted << :role if current_user.admin?
    params.require(:user).permit(permitted)
  end
end
