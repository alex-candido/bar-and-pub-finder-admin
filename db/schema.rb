# frozen_string_literal: true

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

ActiveRecord::Schema[7.2].define(version: 2025_01_21_175319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.jsonb "info", default: {}
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.geography "coords", limit: { srid: 4326, type: "st_point", geographic: true }, null: false
    t.integer "type", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coords"], name: "index_places_on_coords", using: :gist
    t.index ["latitude", "longitude"], name: "index_places_on_latitude_and_longitude"
    t.index ["status"], name: "index_places_on_status"
    t.index ["type"], name: "index_places_on_type"
  end
end
