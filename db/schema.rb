# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_16_170537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "road_route_points", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.bigint "road_route_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["road_route_id"], name: "index_road_route_points_on_road_route_id"
  end

  create_table "road_routes", force: :cascade do |t|
    t.bigint "track_device_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["track_device_id"], name: "index_road_routes_on_track_device_id"
    t.index ["vehicle_id"], name: "index_road_routes_on_vehicle_id"
  end

  create_table "track_devices", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "serial"
    t.boolean "enable", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_track_devices_on_company_id"
  end

  create_table "vehicle_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "vehicle_kind_id"
    t.bigint "track_device_id"
    t.string "patent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["track_device_id"], name: "index_vehicles_on_track_device_id"
    t.index ["vehicle_kind_id"], name: "index_vehicles_on_vehicle_kind_id"
  end

  add_foreign_key "road_route_points", "road_routes"
  add_foreign_key "road_routes", "track_devices"
  add_foreign_key "road_routes", "vehicles"
  add_foreign_key "track_devices", "companies"
end
