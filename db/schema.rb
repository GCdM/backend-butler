# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_30_135603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_users", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "household_id"
    t.datetime "date"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_events_on_household_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "description"
    t.datetime "date"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "GBP", null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "households", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "user_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "GBP", null: false
    t.boolean "paid"
    t.boolean "received"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_payments_on_expense_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "display_name"
    t.string "password_digest"
    t.string "img_url"
    t.bigint "household_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_users_on_household_id"
  end

  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "events", "households"
  add_foreign_key "expenses", "users"
  add_foreign_key "payments", "expenses"
  add_foreign_key "payments", "users"
  add_foreign_key "users", "households"
end
