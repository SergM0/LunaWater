# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :usuario_actual

  def usuario_actual
    @usuario_actual ||= Usuario.find_by(id: session[:usuario_id])
  end

  def autenticar_admin!
    unless usuario_actual && usuario_actual.rol == 'admin'
      redirect_to login_path, alert: "Debes iniciar sesión como administrador"
    end
  end
end
