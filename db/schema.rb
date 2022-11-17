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

ActiveRecord::Schema[7.0].define(version: 2022_11_17_193912) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "coverage_pricings", force: :cascade do |t|
    t.integer "status", default: 0
    t.decimal "percentage_price"
    t.integer "package_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "package_coverage_id"
    t.index ["package_coverage_id"], name: "index_coverage_pricings_on_package_coverage_id"
    t.index ["package_id"], name: "index_coverage_pricings_on_package_id"
  end

  create_table "insurance_companies", force: :cascade do |t|
    t.string "name"
    t.string "email_domain"
    t.integer "company_status", default: 0
    t.integer "token_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "registration_number"
    t.string "token"
    t.index ["registration_number"], name: "index_insurance_companies_on_registration_number", unique: true
    t.index ["token"], name: "index_insurance_companies_on_token", unique: true
  end

  create_table "package_coverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_package_coverages_on_name", unique: true
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "max_period"
    t.integer "min_period"
    t.integer "insurance_company_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_category_id", null: false
    t.integer "status", default: 0
    t.index ["insurance_company_id"], name: "index_packages_on_insurance_company_id"
    t.index ["product_category_id"], name: "index_packages_on_product_category_id"
  end

  create_table "pending_packages", force: :cascade do |t|
    t.string "name"
    t.integer "min_period"
    t.integer "max_period"
    t.integer "insurance_company_id", null: false
    t.integer "product_category_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_company_id"], name: "index_pending_packages_on_insurance_company_id"
    t.index ["product_category_id"], name: "index_pending_packages_on_product_category_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "code"
    t.date "expiration_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_name"
    t.string "client_registration_number"
    t.string "client_email"
    t.integer "equipment_id"
    t.date "purchase_date"
    t.integer "policy_period"
    t.integer "package_id"
    t.integer "order_id"
    t.integer "insurance_company_id", null: false
    t.index ["code"], name: "index_policies_on_code", unique: true
    t.index ["insurance_company_id"], name: "index_policies_on_insurance_company_id"
    t.index ["order_id"], name: "index_policies_on_order_id", unique: true
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name", unique: true
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

  create_table "service_pricings", force: :cascade do |t|
    t.integer "status", default: 0
    t.decimal "percentage_price"
    t.integer "package_id", null: false
    t.integer "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_service_pricings_on_package_id"
    t.index ["service_id"], name: "index_service_pricings_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "code"
    t.index ["code"], name: "index_services_on_code", unique: true
    t.index ["name"], name: "index_services_on_name", unique: true
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
    t.integer "insurance_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["insurance_company_id"], name: "index_users_on_insurance_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "coverage_pricings", "package_coverages"
  add_foreign_key "coverage_pricings", "packages"
  add_foreign_key "packages", "insurance_companies"
  add_foreign_key "packages", "product_categories"
  add_foreign_key "pending_packages", "insurance_companies"
  add_foreign_key "pending_packages", "product_categories"
  add_foreign_key "policies", "insurance_companies"
  add_foreign_key "products", "product_categories"
  add_foreign_key "service_pricings", "packages"
  add_foreign_key "service_pricings", "services"
  add_foreign_key "users", "insurance_companies"
end
