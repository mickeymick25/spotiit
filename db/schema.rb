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

ActiveRecord::Schema.define(version: 2021_07_05_225036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annonceurs", force: :cascade do |t|
    t.integer "sucessed_Ad"
    t.integer "failed_Ad"
    t.integer "reward_engaged"
    t.integer "reward_paid"
    t.integer "reward_topay"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

# Could not dump table "classifiedads" because of following StandardError
#   Unknown type 'ads_status' for column 'adsstatus'

  create_table "localisations", force: :cascade do |t|
    t.integer "number"
    t.text "street_type"
    t.text "street"
    t.text "district"
    t.text "city"
    t.integer "dept"
    t.text "region"
    t.decimal "logitude"
    t.decimal "latitude"
    t.integer "radius"
    t.integer "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

# Could not dump table "propertyads" because of following StandardError
#   Unknown type 'orientation' for column 'orientation'

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "classifiedads", "localisations"
  add_foreign_key "propertyads", "classifiedads"
end
