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

ActiveRecord::Schema.define(version: 20151107184747) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cmor_cms_content_boxes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_cms_folders", force: :cascade do |t|
    t.string   "basename"
    t.string   "pathname"
    t.integer  "children_count",          default: 0, null: false
    t.integer  "cmor_cms_templates_count", default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_folders", ["parent_id"], name: "index_cmor_cms_folders_on_parent_id"

  create_table "cmor_cms_navigation_items", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "key"
    t.string   "options"
    t.text     "properties"
    t.integer  "cmor_cms_navigation_id"
    t.integer  "cmor_cms_page_id"
    t.integer  "parent_id"
    t.integer  "children_count",        default: 0, null: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_navigation_items", ["cmor_cms_navigation_id"], name: "index_cmor_cms_navigation_items_on_cmor_cms_navigation_id"
  add_index "cmor_cms_navigation_items", ["parent_id"], name: "index_cmor_cms_navigation_items_on_parent_id"

  create_table "cmor_cms_navigations", force: :cascade do |t|
    t.string   "locale"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_cms_page_content_blocks", force: :cascade do |t|
    t.text     "body"
    t.integer  "cmor_cms_page_id"
    t.integer  "cmor_cms_content_box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_page_content_blocks", ["cmor_cms_content_box_id"], name: "index_cmor_cms_page_content_blocks_on_cmor_cms_content_box_id"
  add_index "cmor_cms_page_content_blocks", ["cmor_cms_page_id"], name: "index_cmor_cms_page_content_blocks_on_cmor_cms_page_id"

  create_table "cmor_cms_pages", force: :cascade do |t|
    t.string   "basename"
    t.string   "pathname"
    t.string   "title"
    t.text     "meta_description"
    t.text     "body"
    t.string   "layout"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_pages", ["cmor_cms_folder_id"], name: "index_cmor_cms_pages_on_cmor_cms_folder_id"

  create_table "cmor_cms_partials", force: :cascade do |t|
    t.string   "basename"
    t.string   "pathname"
    t.text     "body"
    t.string   "layout"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_partials", ["cmor_cms_folder_id"], name: "index_cmor_cms_partials_on_cmor_cms_folder_id"

  create_table "cmor_cms_templates", force: :cascade do |t|
    t.string   "basename"
    t.string   "pathname"
    t.text     "body"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cmor_cms_templates", ["cmor_cms_folder_id"], name: "index_cmor_cms_templates_on_cmor_cms_folder_id"

end
