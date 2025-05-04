# app/models/usuario.rb
class Usuario < ApplicationRecord
  has_secure_password
end
