class SessionsController < ApplicationController
  def new
    @role = normalize_role(params[:role].presence || current_user&.[](:role))
  end

  def create
    permitted = params.require(:session).permit(:name, :email, :role)
    @role = normalize_role(permitted[:role])

    email = permitted[:email].to_s.strip
    name = permitted[:name].to_s.strip

    if email.blank?
      flash.now[:alert] = "El correo electrónico es obligatorio."
      render :new, status: :unprocessable_entity
      return
    end

    session[:current_user] = {
      name: name.presence || default_name_from_email(email),
      email: email,
      role: @role
    }

    redirect_to dashboard_path, notice: "Sesión iniciada correctamente."
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Sesión cerrada."
  end

  private

  def default_name_from_email(email)
    local_part = email.split("@").first.to_s
    return "Invitado" if local_part.blank?

    local_part.split(/[._-]/).map(&:capitalize).join(" ")
  end
end