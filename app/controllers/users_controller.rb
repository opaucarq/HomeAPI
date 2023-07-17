class UsersController < ApplicationController
  def index
    user = User.all
    render json: user
  end

  def show
    id = params[:id]
    user = User.find_by(id: id)
    render json: user
  end
end
