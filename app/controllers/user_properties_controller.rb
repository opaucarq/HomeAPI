class UserPropertiesController < ApplicationController
  before_action :authenticate_user

  def index
    authenticate_user
    render json: @current_user.properties
  end

  private

  def authenticate_user
    auth_token = request.headers["Authorization"]
    @current_user = User.find_by(auth_token:)
    puts "//////////////////////////////////////"
    p @current_user
    return if @current_user

    render json: { error: "No autorizado." }, status: :unauthorized
  end
end
