class DashboardController < ApplicationController
  before_action :requerir_login

  def index
    @volumen_total = Medicion.sum(:volumen_m3).to_f.round(3)
    @flujo_promedio = Medicion.average(:flujo_promedio).to_f.round(2)
    @duracion_total = Medicion.sum(:duracion_min).to_f.round(2)
    @total_garrafones = Medicion.sum(:volumen_garrafones).to_f.round(2)

    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(50)

    # Datos para la gráfica de distribución
    colores = ["#00C49F", "#0088FE", "#FFBB28", "#FF8042", "#A569BD", "#17A2B8", "#E74C3C", "#3498DB", "#1ABC9C", "#9B59B6"]
    @mediciones_datos = @mediciones.map.with_index(1) do |medicion, index|
      {
        nombre_sensor: "Medición #{index}",
        volumen_m3: medicion.volumen_m3.round(3),
        color: colores[index - 1]
      }
    end
  end

  def datos
    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(50)
  end

  def flujo
    # lógica para gráficas de flujo
  end

  def volumen
    # lógica para resumen de volumen
  end

  def distribucion
    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(10)

    @volumen_total = @mediciones.sum(:volumen_m3).round(3)
    @mediciones_datos = @mediciones.map.with_index(1) do |medicion, index|
      {
        nombre_sensor: "Medición #{index}",
        volumen_m3: medicion.volumen_m3.round(3),
        color: ["#00C49F", "#0088FE", "#FFBB28", "#FF8042", "#A569BD", "#17A2B8", "#E74C3C", "#3498DB", "#1ABC9C", "#9B59B6"][index - 1]
      }
    end
  end


  def exportar
    respond_to do |format|
      format.csv do
        csv_data = Medicion.includes(:sensor).map do |medicion|
          [
            medicion.id,
            medicion.sensor.nombre,
            medicion.inicio.strftime("%d/%m/%Y %H:%M"),
            medicion.fin.strftime("%d/%m/%Y %H:%M"),
            medicion.duracion,
            medicion.flujo,
            medicion.volumen,
            medicion.garrafones,
            medicion.estado
          ].join(",")
        end.join("\n")

        send_data csv_data, filename: "mediciones.csv"
      end
      format.html { redirect_to dashboard_index_path, alert: "Formato no soportado" }
    end
  end

end
