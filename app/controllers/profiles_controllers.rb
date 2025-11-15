class ProfilesController < ApplicationController
  before_action :require_login

  def show
  end

  def update
    updated_profile = profile_params

    if updated_profile[:name].blank? || updated_profile[:email].blank?
      flash.now[:alert] = "El nombre y el correo no pueden estar vacíos."
      render :show, status: :unprocessable_entity
      return
    end

    session[:current_user] = current_user.merge(updated_profile).to_h.stringify_keys
    redirect_to profile_path, notice: "Perfil actualizado."
  end

  private

  def profile_params
    permitted = params.require(:profile).permit(:name, :email, :role).to_h.symbolize_keys
    permitted[:role] = normalize_role(permitted[:role].presence || current_user[:role])
    permitted
  end
end