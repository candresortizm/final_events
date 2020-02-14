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

ActiveRecord::Schema.define(version: 2020_02_14_160005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "location_types", force: :cascade do |t|
    t.bigint "sale_event_id", null: false
    t.string "name", null: false
    t.decimal "price", null: false
    t.decimal "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sale_event_id"], name: "index_location_types_on_sale_event_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "location_type_id", null: false
    t.bigint "client_id"
    t.string "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["location_type_id"], name: "index_reservations_on_location_type_id"
  end

  create_table "sale_events", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "image", null: false
    t.string "place"
    t.datetime "event_date", null: false
    t.bigint "admin_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_sale_events_on_admin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "type", default: "Client", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "location_types", "sale_events"
  add_foreign_key "reservations", "location_types"
  add_foreign_key "reservations", "users", column: "client_id"
  add_foreign_key "sale_events", "users", column: "admin_id"
end
