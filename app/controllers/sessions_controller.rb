class SessionsController < ApplicationController
  before_action :authenticate_user, except: :create

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      user.regenerate_auth_token
      render json: { user: user, auth_token: user.auth_token }
    else

      render json: { error: "Credenciales inválidas." }, status: :unauthorized
    end
  end

  def destroy
    current_user&.invalidate_auth_token
    head :no_content
  end
end
