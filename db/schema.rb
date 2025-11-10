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

ActiveRecord::Schema[8.0].define(version: 2025_11_10_190604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "professional_profile_id"
    t.datetime "date", null: false
    t.integer "days", default: 1, null: false
    t.string "status", default: "pending", null: false
    t.string "address", null: false
    t.text "description", null: false
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "attachments", default: [], null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["professional_profile_id"], name: "index_bookings_on_professional_profile_id"
    t.index ["subscription_id"], name: "index_bookings_on_subscription_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone"
    t.string "status", default: "new", null: false
    t.string "source"
    t.text "notes"
    t.bigint "customer_id"
    t.bigint "professional_profile_id"
    t.datetime "follow_up_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_leads_on_customer_id"
    t.index ["follow_up_at"], name: "index_leads_on_follow_up_at"
    t.index ["professional_profile_id"], name: "index_leads_on_professional_profile_id"
    t.index ["status"], name: "index_leads_on_status"
  end

  create_table "material_orders", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.text "items_json", null: false
    t.integer "total_cost_cents", null: false
    t.integer "margin_cents", null: false
    t.string "status", default: "pending", null: false
    t.string "provider_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_material_orders_on_booking_id", unique: true
  end

  create_table "professional_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "years_experience", null: false
    t.string "zone", null: false
    t.integer "day_rate", default: 200, null: false
    t.boolean "verified", default: false
    t.float "rating_avg", default: 0.0
    t.integer "rating_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_professional_profiles_on_user_id", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "booking_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "name"
    t.integer "price_cents"
    t.integer "yearly_hours"
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subscription_plan_id", null: false
    t.boolean "active"
    t.datetime "started_at"
    t.datetime "cancelled_at"
    t.integer "remaining_hours"
    t.string "external_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "role", default: "customer", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookings", "professional_profiles"
  add_foreign_key "bookings", "users", column: "customer_id"
  add_foreign_key "leads", "professional_profiles"
  add_foreign_key "leads", "users", column: "customer_id"
  add_foreign_key "material_orders", "bookings"
  add_foreign_key "professional_profiles", "users"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "reviews", "users", column: "customer_id"
  add_foreign_key "subscriptions", "subscription_plans"
  add_foreign_key "subscriptions", "users"
end
