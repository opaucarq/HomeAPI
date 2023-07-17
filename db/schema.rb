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

ActiveRecord::Schema[7.0].define(version: 2023_07_17_213708) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operations", force: :cascade do |t|
    t.text "text"
    t.text "address"
    t.integer "price"
    t.integer "maintenance"
    t.boolean "pets"
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "area"
    t.text "description"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.text "operation"
    t.text "address"
    t.integer "price"
    t.integer "maintenance"
    t.boolean "pets"
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "area"
    t.text "description"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_properties", force: :cascade do |t|
    t.boolean "active"
    t.boolean "closed"
    t.boolean "favorite"
    t.boolean "contacted"
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_user_properties_on_property_id"
    t.index ["user_id"], name: "index_user_properties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.text "name"
    t.string "email"
    t.string "phone"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_properties", force: :cascade do |t|
    t.boolean "active"
    t.boolean "closed"
    t.boolean "favorite"
    t.boolean "contacted"
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_users_properties_on_property_id"
    t.index ["user_id"], name: "index_users_properties_on_user_id"
  end

  add_foreign_key "user_properties", "properties"
  add_foreign_key "user_properties", "users"
  add_foreign_key "users_properties", "properties"
  add_foreign_key "users_properties", "users"
end
