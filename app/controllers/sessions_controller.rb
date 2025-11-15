class SessionsController < ApplicationController
  def new
    @role = normalize_role(params[:role].presence || current_user&.[](:role))
  end

  def create
    permitted = params.require(:session).permit(:email, :password, :role)
    @role = normalize_role(permitted[:role])

    email = permitted[:email].to_s.strip.downcase
    password = permitted[:password].to_s

    if email.blank? || password.blank?
      flash.now[:alert] = "El correo y la contraseña son obligatorios."
      render :new, status: :unprocessable_entity
      return
    end

    user = find_user_by_email(email)

    if user&.authenticate(password)
      session[:current_user] = session_payload_for(user)
      redirect_to dashboard_path, notice: "Sesión iniciada correctamente."
      return
    end

    flash.now[:alert] = "Correo o contraseña incorrectos."
    render :new, status: :unprocessable_entity
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Sesión cerrada."
  end

  private

  def find_user_by_email(email)
    User.where("LOWER(email) = ?", email.downcase).first
  end

  def session_payload_for(user)
    {
      "id" => user.id,
      "name" => user.name,
      "email" => user.email,
      "role" => user.role == "professional" ? "professional" : "client"
    }
  end
end