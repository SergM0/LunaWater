class Sensor < ApplicationRecord
  self.table_name = "sensor"

  has_many :mediciones
end
