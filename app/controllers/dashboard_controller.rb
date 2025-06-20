class DashboardController < ApplicationController
  before_action :requerir_login

  def index
    @volumen_total = Medicion.sum(:volumen_m3).to_f.round(3)
    @flujo_promedio = Medicion.average(:flujo_promedio).to_f.round(2)
    @duracion_total = Medicion.sum(:duracion_min).to_f.round(2)
    @total_garrafones = Medicion.sum(:volumen_garrafones).to_f.round(2)

    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(50)

    # Datos para el gráfico de flujo
    @flujo_datos = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(10).map do |medicion|
      {
        timestamp: medicion.timestamp_inicio.strftime("%H:%M"),
        flujo: medicion.flujo_promedio.round(2),
        duracion: medicion.duracion_min.round(2)
      }
    end


    # Datos para la gráfica de distribución
    colores = ["#00C49F", "#0088FE", "#FFBB28", "#FF8042", "#A569BD", "#17A2B8", "#E74C3C", "#3498DB", "#1ABC9C", "#9B59B6"]
    @mediciones_datos = @mediciones.map.with_index(1) do |medicion, index|
      {
        nombre_sensor: "Medición #{index}",
        volumen_m3: medicion.volumen_m3.round(3),
        color: colores[index - 1]
      }
    end

    @volumen_datos = @mediciones.map do |medicion|
      {
        timestamp: medicion.timestamp_inicio.strftime("%H:%M"),
        volumen_m3: medicion.volumen_m3.round(3),
        garrafones: medicion.volumen_garrafones.round(2)
      }
    end

  end

  def datos
    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(50)
  end

  # app/controllers/dashboard_controller.rb
  def flujo
    @flujo_datos = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(10).map do |medicion|
      {
        timestamp: medicion.timestamp_inicio.strftime("%H:%M"),
        flujo: medicion.flujo_promedio.round(2),
        duracion: medicion.duracion_min.round(2)
      }
    end
  end


  def volumen
    @mediciones = Medicion.includes(:sensor).order(timestamp_inicio: :desc).limit(10)

    @volumen_datos = @mediciones.map do |medicion|
      {
        timestamp: medicion.timestamp_inicio.strftime("%H:%M"),
        volumen_m3: medicion.volumen_m3.round(3),
        garrafones: medicion.volumen_garrafones.round(2)
      }
    end
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
