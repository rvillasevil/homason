class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :set_current_user

  layout false

  attr_reader :current_user
  helper_method :current_user

  private

  def set_current_user
    auth = request.headers["Authorization"]
    return unless auth&.start_with?("Bearer ")

    token = auth.split(" ").last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
  end

  def authenticate_user!
    return if current_user

    respond_to do |format|
      format.html { redirect_to login_redirect_path, alert: "Debes iniciar sesión para continuar." }
      format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      format.any { head :unauthorized }
    end
  end

  def require_role!(*roles)
    return if current_user && roles.map(&:to_s).include?(current_user.role)

    respond_to do |format|
      format.html { redirect_to root_path, alert: "No tienes permisos para acceder a esta sección." }
      format.json { render json: { error: "Forbidden" }, status: :forbidden }
      format.any { head :forbidden }
    end
  end

  def login_redirect_path
    if request.path.start_with?("/professionals")
      professionals_login_path
    elsif request.path.start_with?("/clients")
      clients_login_path
    else
      root_path
    end
  end
end
