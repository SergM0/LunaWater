class Medicion < ApplicationRecord
  self.table_name = "mediciones"
  belongs_to :sensor

  validates :sensor, presence: true
  validates :inicio, :fin, :duracion, :flujo, :volumen, :garrafones, :estado, presence: true

  def nombre_sensor
    "Medición #{self.id}"
  end

end
