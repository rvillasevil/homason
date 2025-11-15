class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout "application"

  helper_method :current_user, :user_signed_in?, :role_label, :role_options

  ROLE_OPTIONS = {
    "client" => "Cliente",
    "professional" => "Profesional"
  }.freeze

  private

  def current_user
    session[:current_user]&.with_indifferent_access
  end

  def user_signed_in?
    current_user.present?
  end

  def role_label(role)
    ROLE_OPTIONS[role] || ROLE_OPTIONS["client"]
  end

  def role_options
    ROLE_OPTIONS
  end

  def normalize_role(role_param)
    role_param == "professional" ? "professional" : "client"
  end

  def require_login
    return if user_signed_in?

    redirect_to new_session_path, alert: "Debes iniciar sesión para continuar."
  end
end


# DashboardsController is frequently loaded before the profile screen, so we
# eagerly load the profile controller from here to guarantee the constant exists
# even when Zeitwerk hasn't noticed new files yet (for example, in long-running
# development servers).
if defined?(Rails) && defined?(require_dependency)
  require_dependency Rails.root.join("app/controllers/profiles_controller").to_s
else
  require_relative "profiles_controller"
end
