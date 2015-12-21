# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151221185413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "consignees", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "address_line_1", null: false
    t.text     "address_line_2"
    t.string   "po_box_no",      null: false
    t.string   "city"
    t.string   "country",        null: false
    t.string   "tel_no_1",       null: false
    t.string   "tel_no_2"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hawbs", force: :cascade do |t|
    t.integer  "number",     limit: 8
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "manifests", force: :cascade do |t|
    t.string   "mawb",                                  null: false
    t.integer  "order_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "orders_to_manifest",       default: [],              array: true
    t.string   "hawb_numbers_to_manifest", default: [],              array: true
  end

  add_index "manifests", ["order_id"], name: "index_manifests_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "hawb_number"
    t.integer  "shipper_id"
    t.integer  "consignee_id"
    t.integer  "total_pieces"
    t.decimal  "total_weight"
    t.decimal  "items_cost"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.hstore   "baggage_data"
  end

  add_index "orders", ["consignee_id"], name: "index_orders_on_consignee_id", using: :btree
  add_index "orders", ["shipper_id"], name: "index_orders_on_shipper_id", using: :btree

  create_table "shippers", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "address_line_1", null: false
    t.text     "address_line_2"
    t.string   "city"
    t.string   "country",        null: false
    t.string   "tel_no",         null: false
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "manifests", "orders"
  add_foreign_key "orders", "consignees"
  add_foreign_key "orders", "shippers"
end
