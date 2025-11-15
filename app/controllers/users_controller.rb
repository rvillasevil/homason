class UsersController < ApplicationController
  before_action :set_role

  ROLE_PARAM_TO_USER_ROLE = {
    "client" => "customer",
    "professional" => "professional"
  }.freeze

  def new
    @user = User.new(role: ROLE_PARAM_TO_USER_ROLE[@role])
  end

  def create
    @user = User.new(user_params)
    @user.role = ROLE_PARAM_TO_USER_ROLE[@role]

    if @user.save
      redirect_to new_session_path(role: @role), notice: "Cuenta creada con éxito. Ahora puedes iniciar sesión."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_role
    @role = normalize_role(params[:role])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :address, :password, :password_confirmation)
  end
end