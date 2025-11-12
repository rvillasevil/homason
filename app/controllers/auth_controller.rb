class AuthController < ApplicationController
  skip_before_action :set_current_user

  layout -> { request.format.html? ? "marketing" : false }

  def signup
    user = User.new(user_params)

    respond_to do |format|
      if user.save
        format.json { render json: success_payload(user), status: :created }
        format.html do
          complete_html_login(user)
          redirect_to after_auth_redirect_for(user), status: :see_other
        end
      else
        format.json { render json: { errors: user.errors.full_messages }, status: :unprocessable_entity }
        format.html do
          assign_form_state(user_params, user.errors.full_messages)
          render signup_template_for(user.role), status: :unprocessable_entity
        end
      end
    end
  end

  def login
    user = User.find_by(email: login_params[:email])

    respond_to do |format|
      if user&.authenticate(login_params[:password])
        format.json { render json: success_payload(user) }
        format.html do
          complete_html_login(user)
          redirect_to after_auth_redirect_for(user), status: :see_other
        end
      else
        format.json { render json: { error: "Credenciales inválidas" }, status: :unauthorized }
        format.html do
          assign_form_state(login_params, ["Credenciales inválidas. Comprueba tu correo y contraseña."])
          render login_template_for(login_params[:role]), status: :unauthorized
        end
      end
    end
  end

  private

  def success_payload(user)
    token = JsonWebToken.encode(user_id: user.id)
    { user: user, token: token }
  end

  def complete_html_login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def after_auth_redirect_for(user)
    return professionals_dashboard_path if user.professional?
    return clients_dashboard_path if user.customer?

    root_path
  end

  def assign_form_state(data, errors)
    filtered = data.to_h.symbolize_keys.slice(:name, :email, :phone, :address, :role)
    filtered[:role] ||= params[:role] || "customer"
    filtered[:email] ||= params[:email]
    @form_data = filtered
    @form_errors = errors
  end

  def signup_template_for(role)
    role == "professional" ? "professionals/registrations/new" : "clients/registrations/new"
  end

  def login_template_for(role)
    role == "professional" ? "professionals/sessions/new" : "clients/sessions/new"
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role, :phone, :address)
  end

  def login_params
    params.permit(:email, :password, :role)
  end
end
