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

ActiveRecord::Schema[7.0].define(version: 2022_11_04_231251) do
  create_table "coverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurance_companies", force: :cascade do |t|
    t.string "name"
    t.string "email_domain"
    t.integer "company_status", default: 0
    t.string "token"
    t.integer "token_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "max_period"
    t.integer "min_period"
    t.integer "insurance_company_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_company_id"], name: "index_packages_on_insurance_company_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "code"
    t.date "expiration_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_model"
    t.string "launch_year"
    t.string "brand"
    t.decimal "price"
    t.integer "status", default: 0
    t.integer "product_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "insurance_company_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["insurance_company_id"], name: "index_users_on_insurance_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "packages", "insurance_companies"
  add_foreign_key "products", "product_categories"
  add_foreign_key "users", "insurance_companies"
end
