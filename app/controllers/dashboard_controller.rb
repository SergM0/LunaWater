class DashboardController < ApplicationController
  before_action :requerir_login

  def index
    @volumen_total = 0.297
    @flujo_promedio = 5.58
    @duracion_total = 60.0
    @total_garrafones = 15.62
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
    # lógica para distribución de consumo
  end

  def exportar
    # Aquí iría la lógica para exportar a CSV, por ahora solo redirige o muestra algo simple
    respond_to do |format|
      format.csv { send_data "ID,Sensor,Fecha\n1,Sensor A,04/05/2025", filename: "mediciones.csv" }
      format.html { redirect_to dashboard_index_path, alert: "Formato no soportado" }
    end
  end

end
