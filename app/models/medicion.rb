class Medicion < ApplicationRecord
  self.table_name = "mediciones"
  belongs_to :sensor
end
