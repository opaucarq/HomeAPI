class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  helper_method :current_user

  private

  def authenticate_user
    auth_token = request.headers["Authorization"]
    @current_user = User.find_by(auth_token:)
    p @current_user
    puts "------------------------------------"
    render json: { error: "No autorizado." }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
