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

ActiveRecord::Schema.define(version: 20180310081500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contract_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "idx_unique_contract_kind_name", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "contract_kind_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_kind_id"], name: "index_contracts_on_contract_kind_id"
    t.index ["customer_id"], name: "index_contracts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.boolean "gender"
    t.date "birthday"
    t.string "phone"
    t.integer "status"
    t.string "school"
    t.string "merchandise"
    t.string "nic_number"
  end

  create_table "customers_steps", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_staff_id"
    t.integer "assigned_staff_id"
    t.integer "status"
    t.datetime "assigned_at"
    t.bigint "contract_id"
    t.index ["contract_id"], name: "index_customers_steps_on_contract_id"
    t.index ["customer_id"], name: "index_customers_steps_on_customer_id"
    t.index ["step_id"], name: "index_customers_steps_on_step_id"
  end

  create_table "document_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "idx_unique_document_kind_name", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "document_kind_id", null: false
    t.string "filename", null: false
    t.string "url", null: false
    t.string "physic_path", null: false
    t.string "content_type", null: false
    t.integer "size", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "staff_id", null: false
    t.index ["customer_id"], name: "index_documents_on_customer_id"
    t.index ["document_kind_id"], name: "index_documents_on_document_kind_id"
    t.index ["staff_id"], name: "index_documents_on_staff_id"
  end

  create_table "form_input_conditions", force: :cascade do |t|
    t.string "condition", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_input_kinds", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind", "deleted_at"], name: "idx_unique_form_input_kind", unique: true
  end

  create_table "form_input_values", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "form_id", null: false
    t.bigint "form_input_kind_id", null: false
    t.json "form_input_condition_ids", null: false
    t.datetime "deleted_at"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_form_input_values_on_contract_id"
    t.index ["form_id"], name: "index_form_input_values_on_form_id"
    t.index ["form_input_kind_id"], name: "index_form_input_values_on_form_input_kind_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "step_id"
    t.bigint "contract_kind_id"
    t.string "name", null: false
    t.boolean "is_template", default: true, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_kind_id"], name: "index_forms_on_contract_kind_id"
    t.index ["name", "deleted_at"], name: "idx_unique_form_name", unique: true
    t.index ["step_id"], name: "index_forms_on_step_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "parent_id"
    t.integer "level"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_schedules", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.datetime "pay_date", null: false
    t.float "pay_amount", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_payment_schedules_on_contract_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "controller_path"
    t.string "action_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revisions", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "kind", null: false
    t.text "value"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "level", default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.integer "parent_id"
    t.index ["name", "deleted_at"], name: "idx_unique_role_name", unique: true
    t.index ["organization_id"], name: "index_roles_on_organization_id"
  end

  create_table "roles_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.bigint "organization_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_roles_permissions_on_organization_id"
    t.index ["permission_id"], name: "index_roles_permissions_on_permission_id"
    t.index ["role_id"], name: "index_roles_permissions_on_role_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "mobile_phone", null: false
    t.datetime "deleted_at"
    t.index ["email", "deleted_at"], name: "idx_unique_staff_email", unique: true
    t.index ["email"], name: "index_staffs_on_email", unique: true
    t.index ["mobile_phone", "deleted_at"], name: "idx_unique_staff_mobile_phone", unique: true
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
  end

  create_table "staffs_roles", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "staff_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_staffs_roles_on_role_id"
    t.index ["staff_id"], name: "index_staffs_roles_on_staff_id"
  end

  create_table "step_conditions", force: :cascade do |t|
    t.bigint "step_id"
    t.text "condition", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_step_conditions_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "prev_step_id"
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "next_step_id"
    t.bigint "form_id"
    t.bigint "product_id"
    t.index ["form_id"], name: "index_steps_on_form_id"
    t.index ["product_id"], name: "index_steps_on_product_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "payment_schedule_id", null: false
    t.float "amount", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_schedule_id"], name: "index_transactions_on_payment_schedule_id"
  end

  add_foreign_key "contracts", "contract_kinds"
  add_foreign_key "contracts", "customers"
  add_foreign_key "customers_steps", "contracts"
  add_foreign_key "customers_steps", "customers"
  add_foreign_key "customers_steps", "steps"
  add_foreign_key "documents", "customers"
  add_foreign_key "documents", "document_kinds"
  add_foreign_key "documents", "staffs"
  add_foreign_key "form_input_values", "contracts"
  add_foreign_key "form_input_values", "form_input_kinds"
  add_foreign_key "form_input_values", "forms"
  add_foreign_key "forms", "contract_kinds"
  add_foreign_key "forms", "steps"
  add_foreign_key "payment_schedules", "contracts"
  add_foreign_key "roles", "organizations"
  add_foreign_key "roles_permissions", "organizations"
  add_foreign_key "roles_permissions", "permissions"
  add_foreign_key "roles_permissions", "roles"
  add_foreign_key "staffs_roles", "roles"
  add_foreign_key "staffs_roles", "staffs"
  add_foreign_key "step_conditions", "steps"
  add_foreign_key "steps", "forms"
  add_foreign_key "steps", "products"
  add_foreign_key "transactions", "payment_schedules"
end
