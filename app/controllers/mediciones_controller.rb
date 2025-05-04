  class MedicionesController < ApplicationController

    before_action :autenticar_admin!

    def index
      cliente = PgSupabaseClient.new

      # Ya devuelve un array de hashes
      mediciones_raw = cliente.obtener_mediciones

      # Obtener sensores
      sensores = cliente.obtener_sensores
      sensores = sensores.is_a?(Array) ? sensores : []

      # Crear un hash { sensor_id => nombre }
      sensor_map = sensores.index_by { |s| s["id"] }

      # Agregar nombre del sensor a cada medición
      @mediciones = mediciones_raw.map do |medicion|
        medicion["sensor_nombre"] = sensor_map[medicion["sensor_id"]]&.dig("nombre") || "Desconocido"
        medicion
      end
    end
  end


