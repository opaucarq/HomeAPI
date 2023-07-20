class UserPropertiesController < ApplicationController
  before_action :require_login

  def tu_accion_protegida
    # Resto del código para la acción protegida...
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: 'Debes iniciar sesión para acceder a esta página.'
    end
  end
end
