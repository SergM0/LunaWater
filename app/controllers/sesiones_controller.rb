class SesionesController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by(correo: params[:correo])

    if usuario&.authenticate(params[:contrasena]) && usuario.rol == "admin"
      session[:usuario_id] = usuario.id
      redirect_to mediciones_path, notice: "Inicio de sesión exitoso"
    else
      flash.now[:alert] = "Correo o contraseña incorrectos"
      render :new
    end
  end

  def destroy
    session.delete(:usuario_id)
    redirect_to login_path, notice: "Sesión cerrada"
  end
end
