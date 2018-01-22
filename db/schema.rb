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

ActiveRecord::Schema.define(version: 20180122111309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contract_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.json "step_ids", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "idx_unique_contract_kind_name", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "user_id", null: false
    t.bigint "contract_kind_id", null: false
    t.string "current_workflow", null: false
    t.string "current_step", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_kind_id"], name: "index_contracts_on_contract_kind_id"
    t.index ["customer_id"], name: "index_contracts_on_customer_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "user_id", null: false
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
    t.index ["customer_id"], name: "index_documents_on_customer_id"
    t.index ["document_kind_id"], name: "index_documents_on_document_kind_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "parent_id"
    t.integer "level"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "action", null: false
    t.text "description"
    t.string "resource_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action", "resource_type", "deleted_at"], name: "idx_unique_action", unique: true
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.bigint "organization_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_permissions_roles_on_organization_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "level", default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "deleted_at"], name: "idx_unique_role_name", unique: true
  end

  create_table "steps", force: :cascade do |t|
    t.integer "prev_step_id"
    t.bigint "contract_kind_id"
    t.string "name", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_kind_id"], name: "index_steps_on_contract_kind_id"
    t.index ["name", "contract_kind_id", "deleted_at"], name: "idx_unique_step_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "role_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "deleted_at"
    t.string "address"
    t.string "phone"
    t.string "mobile_phone", null: false
    t.integer "failed_attemps", default: 0, null: false
    t.datetime "locked_at"
    t.datetime "unlock_token"
    t.index ["email", "deleted_at"], name: "idx_unique_user_email", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_phone", "deleted_at"], name: "idx_unique_user_mobile_phone", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "contracts", "contract_kinds"
  add_foreign_key "contracts", "customers"
  add_foreign_key "contracts", "users"
  add_foreign_key "documents", "customers"
  add_foreign_key "documents", "document_kinds"
  add_foreign_key "documents", "users"
  add_foreign_key "permissions_roles", "organizations"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "steps", "contract_kinds"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "roles"
end
