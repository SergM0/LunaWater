require 'pg'

class PgSupabaseClient
  def initialize
    @conn = PG.connect(
      host: 'aws-0-us-east-1.pooler.supabase.com',
      port: 5432,
      dbname: 'postgres',
      user: 'postgres.jvrgcqhclfqylkqrbzuv',
      password: 'dodBu5-sykqoc-keswyn'
    )
  end

  def obtener_usuarios
    result = @conn.exec('SELECT * FROM usuarios')
    result.map { |row| row }  # convierte PG::Result a arreglo de hashes
  rescue PG::Error => e
    Rails.logger.error("❌ Error al conectar con PostgreSQL Supabase: #{e.message}")
    []
  end

  def obtener_mediciones
    result = @conn.exec('SELECT * FROM mediciones ORDER BY timestamp_inicio DESC LIMIT 100')
    result.map { |row| row }
  rescue PG::Error => e
    Rails.logger.error("❌ Error al obtener mediciones: #{e.message}")
    []
  end

  def obtener_sensores
    resultado = @conn.exec("SELECT * FROM sensor ORDER BY fecha_instalacion DESC")
    resultado.to_a
  end


end
