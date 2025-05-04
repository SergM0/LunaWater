# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 0) do
  create_schema "auth"
  create_schema "extensions"
  create_schema "graphql"
  create_schema "graphql_public"
  create_schema "pgbouncer"
  create_schema "pgsodium"
  create_schema "pgsodium_masks"
  create_schema "realtime"
  create_schema "storage"
  create_schema "vault"

  # These are extensions that must be enabled in order to support this database
  enable_extension "extensions.pg_stat_statements"
  enable_extension "extensions.pgcrypto"
  enable_extension "extensions.pgjwt"
  enable_extension "extensions.uuid-ossp"
  enable_extension "graphql.pg_graphql"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgsodium.pgsodium"
  enable_extension "vault.supabase_vault"

  create_table "mediciones", id: :serial, force: :cascade do |t|
    t.integer "sensor_id", null: false
    t.timestamptz "timestamp_inicio", null: false
    t.timestamptz "timestamp_fin", null: false
    t.decimal "flujo_promedio", precision: 5, scale: 2, null: false
    t.decimal "duracion_min", precision: 5, scale: 2, null: false
    t.decimal "volumen_m3", precision: 6, scale: 3, null: false
    t.decimal "volumen_garrafones", precision: 5, scale: 2, null: false
    t.check_constraint "duracion_min >= 0::numeric", name: "mediciones_duracion_min_check"
    t.check_constraint "flujo_promedio >= 0::numeric", name: "mediciones_flujo_promedio_check"
    t.check_constraint "volumen_garrafones >= 0::numeric", name: "mediciones_volumen_garrafones_check"
    t.check_constraint "volumen_m3 >= 0::numeric", name: "mediciones_volumen_m3_check"
  end

  create_table "sensor", id: :serial, force: :cascade do |t|
    t.text "nombre", default: "Ultrasonico R500", null: false
    t.date "fecha_instalacion", default: -> { "CURRENT_DATE" }, null: false
    t.boolean "activo", default: true, null: false
  end

  create_table "usuarios", id: :serial, force: :cascade do |t|
    t.text "nombre", null: false
    t.text "correo", null: false
    t.text "rol", default: "usuario", null: false
    t.timestamptz "creado_en", default: -> { "now()" }, null: false
    t.text "password_digest", default: "", null: false

    t.unique_constraint ["correo"], name: "usuarios_correo_key1"
  end

  add_foreign_key "mediciones", "sensor", name: "mediciones_sensor_id_fkey1", on_delete: :cascade
end
