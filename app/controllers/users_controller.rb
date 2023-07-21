class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user, except: :create
  before_action :set_user, only: %i[show update]

  def show
    if @user
      user = @user.slice("role", "name", "email", "phone")
      render json: user
    else
      render json: "", status: :not_found
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { message: "Usuario creado exitosamente." }
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def user_params
    aux = params.require(:user).permit(:role, :name, :email, :phone, :password_digest)
    aux["password"] = aux.delete("password_digest")
    aux
  end

  def authenticate_user
    auth_token = request.headers["Authorization"]
    return if valid_auth_token?(auth_token)

    render json: { error: "No autorizado." },
           status: :unauthorized
  end

  def valid_auth_token?(auth_token)
    user = User.find_by(auth_token:)
    user.present?
  end

  def set_user
    @user = current_user
  end

  def current_user
    auth_token = request.headers["Authorization"]
    return nil unless auth_token

    User.find_by(auth_token:)
  end
end
