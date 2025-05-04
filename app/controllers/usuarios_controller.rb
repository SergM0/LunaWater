# app/controllers/usuarios_controller.rb
class UsuariosController < ApplicationController
  def index
    cliente = PgSupabaseClient.new
    @usuarios = cliente.obtener_usuarios
  end

end
