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

ActiveRecord::Schema.define(version: 20180324083346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "condition_groups", force: :cascade do |t|
    t.bigint "condition_id"
    t.integer "parent_id"
    t.string "operator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["condition_id", "deleted_at"], name: "index_condition_groups_on_condition_id_and_deleted_at", unique: true
    t.index ["condition_id"], name: "index_condition_groups_on_condition_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.json "condition"
    t.integer "condition_kind", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "contract_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "idx_unique_contract_kind_name", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "contract_kind_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.index ["contract_kind_id"], name: "index_contracts_on_contract_kind_id"
    t.index ["person_id"], name: "index_contracts_on_person_id"
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
    t.bigint "document_kind_id", null: false
    t.text "filename"
    t.text "url"
    t.text "physic_path"
    t.string "content_type"
    t.integer "size"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "staff_id", null: false
    t.bigint "person_id"
    t.index ["document_kind_id"], name: "index_documents_on_document_kind_id"
    t.index ["person_id"], name: "index_documents_on_person_id"
    t.index ["staff_id"], name: "index_documents_on_staff_id"
  end

  create_table "form_fields", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "form_input_id"
    t.bigint "condition_group_id"
    t.bigint "form_object_id"
    t.string "field_name"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "display_name"
    t.index ["condition_group_id", "deleted_at"], name: "index_form_fields_on_condition_group_id_and_deleted_at", unique: true
    t.index ["condition_group_id"], name: "index_form_fields_on_condition_group_id"
    t.index ["form_id", "deleted_at"], name: "index_form_fields_on_form_id_and_deleted_at", unique: true
    t.index ["form_id"], name: "index_form_fields_on_form_id"
    t.index ["form_input_id", "deleted_at"], name: "index_form_fields_on_form_input_id_and_deleted_at", unique: true
    t.index ["form_input_id"], name: "index_form_fields_on_form_input_id"
    t.index ["form_object_id", "deleted_at"], name: "index_form_fields_on_form_object_id_and_deleted_at", unique: true
    t.index ["form_object_id"], name: "index_form_fields_on_form_object_id"
  end

  create_table "form_inputs", force: :cascade do |t|
    t.string "name"
    t.string "render_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "form_objects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "form_values", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "form_field_id"
    t.integer "object_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["form_field_id", "deleted_at"], name: "index_form_values_on_form_field_id_and_deleted_at", unique: true
    t.index ["form_field_id"], name: "index_form_values_on_form_field_id"
    t.index ["form_id", "deleted_at"], name: "index_form_values_on_form_id_and_deleted_at", unique: true
    t.index ["form_id"], name: "index_form_values_on_form_id"
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

  create_table "people", force: :cascade do |t|
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

  create_table "people_steps", force: :cascade do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_staff_id"
    t.integer "assigned_staff_id"
    t.integer "status"
    t.datetime "assigned_at"
    t.bigint "person_id"
    t.bigint "contract_id"
    t.bigint "step_id"
    t.index ["contract_id"], name: "index_people_steps_on_contract_id"
    t.index ["person_id"], name: "index_people_steps_on_person_id"
    t.index ["step_id"], name: "index_people_steps_on_step_id"
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

  add_foreign_key "condition_groups", "conditions"
  add_foreign_key "contracts", "contract_kinds"
  add_foreign_key "contracts", "people"
  add_foreign_key "documents", "document_kinds"
  add_foreign_key "documents", "people"
  add_foreign_key "documents", "staffs"
  add_foreign_key "form_fields", "condition_groups"
  add_foreign_key "form_fields", "form_inputs"
  add_foreign_key "form_fields", "form_objects"
  add_foreign_key "form_fields", "forms"
  add_foreign_key "form_values", "form_fields"
  add_foreign_key "form_values", "forms"
  add_foreign_key "forms", "contract_kinds"
  add_foreign_key "forms", "steps"
  add_foreign_key "payment_schedules", "contracts"
  add_foreign_key "people_steps", "contracts"
  add_foreign_key "people_steps", "people"
  add_foreign_key "people_steps", "steps"
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
