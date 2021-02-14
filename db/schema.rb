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

ActiveRecord::Schema.define(version: 2021_02_13_222724) do

  create_table "certificates", force: :cascade do |t|
    t.string "name"
    t.text "cert"
    t.text "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_folders_on_parent_id"
  end

  create_table "request_examples", force: :cascade do |t|
    t.integer "request_id", null: false
    t.string "name"
    t.string "content_type"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_request_examples_on_request_id"
  end

  create_table "request_headers", force: :cascade do |t|
    t.integer "request_id"
    t.string "name"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "request_example_id"
    t.index ["request_example_id"], name: "index_request_headers_on_request_example_id"
    t.index ["request_id"], name: "index_request_headers_on_request_id"
  end

  create_table "request_params", force: :cascade do |t|
    t.integer "request_id"
    t.string "name"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "request_example_id"
    t.index ["request_example_id"], name: "index_request_params_on_request_example_id"
    t.index ["request_id"], name: "index_request_params_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "method"
    t.string "content_type"
    t.text "body"
    t.integer "folder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "certificate_id"
    t.index ["certificate_id"], name: "index_requests_on_certificate_id"
    t.index ["folder_id"], name: "index_requests_on_folder_id"
  end

  add_foreign_key "folders", "folders", column: "parent_id"
  add_foreign_key "request_examples", "requests"
  add_foreign_key "request_headers", "request_examples"
  add_foreign_key "request_headers", "requests"
  add_foreign_key "request_params", "request_examples"
  add_foreign_key "request_params", "requests"
  add_foreign_key "requests", "certificates"
  add_foreign_key "requests", "folders"
end
