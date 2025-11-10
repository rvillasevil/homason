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
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  def require_role!(*roles)
    unless current_user && roles.map(&:to_s).include?(current_user.role)
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
