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

ActiveRecord::Schema.define(version: 2019_03_01_132158) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cmor_blog_asset_details", force: :cascade do |t|
    t.integer "post_id"
    t.integer "asset_id"
    t.string "title"
    t.text "description"
    t.integer "position"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_cmor_blog_asset_details_on_asset_id"
    t.index ["post_id"], name: "index_cmor_blog_asset_details_on_post_id"
  end

  create_table "cmor_blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "published_at"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["slug"], name: "index_cmor_blog_posts_on_slug", unique: true
  end

  create_table "cmor_carousels_carousels", force: :cascade do |t|
    t.string "locale"
    t.string "identifier"
    t.string "variant_options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_carousels_item_details", force: :cascade do |t|
    t.integer "carousel_id"
    t.integer "asset_id"
    t.string "url"
    t.text "description"
    t.integer "position"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_cms_content_boxes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_cms_folders", force: :cascade do |t|
    t.string "basename"
    t.string "pathname"
    t.integer "children_count", default: 0, null: false
    t.integer "cmor_cms_templates_count", default: 0, null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["parent_id"], name: "index_cmor_cms_folders_on_parent_id"
  end

  create_table "cmor_cms_navigation_items", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "key"
    t.string "options"
    t.text "properties"
    t.integer "cmor_cms_navigation_id"
    t.integer "cmor_cms_page_id"
    t.integer "parent_id"
    t.integer "children_count", default: 0, null: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cmor_cms_navigation_id"], name: "index_cmor_cms_navigation_items_on_cmor_cms_navigation_id"
    t.index ["parent_id"], name: "index_cmor_cms_navigation_items_on_parent_id"
  end

  create_table "cmor_cms_navigations", force: :cascade do |t|
    t.string "locale"
    t.string "name"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_cms_page_content_blocks", force: :cascade do |t|
    t.text "body"
    t.integer "cmor_cms_page_id"
    t.integer "cmor_cms_content_box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cmor_cms_content_box_id"], name: "index_cmor_cms_page_content_blocks_on_cmor_cms_content_box_id"
    t.index ["cmor_cms_page_id"], name: "index_cmor_cms_page_content_blocks_on_cmor_cms_page_id"
  end

  create_table "cmor_cms_pages", force: :cascade do |t|
    t.string "basename"
    t.string "pathname"
    t.string "title"
    t.text "meta_description"
    t.text "body"
    t.string "layout"
    t.string "locale"
    t.string "format"
    t.string "handler"
    t.integer "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cmor_cms_folder_id"], name: "index_cmor_cms_pages_on_cmor_cms_folder_id"
  end

  create_table "cmor_cms_partials", force: :cascade do |t|
    t.string "basename"
    t.string "pathname"
    t.text "body"
    t.string "layout"
    t.string "locale"
    t.string "format"
    t.string "handler"
    t.integer "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cmor_cms_folder_id"], name: "index_cmor_cms_partials_on_cmor_cms_folder_id"
  end

  create_table "cmor_cms_templates", force: :cascade do |t|
    t.string "basename"
    t.string "pathname"
    t.text "body"
    t.string "locale"
    t.string "format"
    t.string "handler"
    t.integer "cmor_cms_folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cmor_cms_folder_id"], name: "index_cmor_cms_templates_on_cmor_cms_folder_id"
  end

  create_table "cmor_contact_contact_requests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "ip_address"
    t.text "message"
    t.boolean "accept_terms_of_service"
    t.datetime "notified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_files_file_details", force: :cascade do |t|
    t.integer "folder_id"
    t.integer "asset_id"
    t.string "title"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_files_folders", force: :cascade do |t|
    t.string "name"
    t.datetime "published_at"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_galleries_picture_details", force: :cascade do |t|
    t.integer "picture_gallery_id"
    t.integer "asset_id"
    t.string "title"
    t.text "description"
    t.integer "position"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_galleries_picture_galleries", force: :cascade do |t|
    t.string "name"
    t.datetime "published_at"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_links_categories", force: :cascade do |t|
    t.string "locale"
    t.string "name"
    t.text "short_description"
    t.text "long_description"
    t.string "markup_language"
    t.integer "link_footer_column"
    t.integer "lft"
    t.integer "rgt"
    t.integer "parent_id"
    t.integer "depth"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_links_links", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "description"
    t.string "markup_language"
    t.integer "category_id"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_cmor_links_links_on_category_id"
  end

  create_table "cmor_rbac_permissions", force: :cascade do |t|
    t.string "identifier"
    t.datetime "enabled_from"
    t.datetime "enabled_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_rbac_role_permissions", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_cmor_rbac_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_cmor_rbac_role_permissions_on_role_id"
  end

  create_table "cmor_rbac_roles", force: :cascade do |t|
    t.string "identifier"
    t.datetime "enabled_from"
    t.datetime "enabled_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cmor_rbac_user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_cmor_rbac_user_roles_on_role_id"
    t.index ["user_id"], name: "index_cmor_rbac_user_roles_on_user_id"
  end

  create_table "cmor_sliders_items", force: :cascade do |t|
    t.integer "slider_id"
    t.integer "position"
    t.string "url"
    t.text "body"
    t.string "markup_language"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_sliders_sliders", force: :cascade do |t|
    t.string "locale"
    t.string "name"
    t.text "description"
    t.boolean "auto_start"
    t.decimal "interval", precision: 8, scale: 2
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cmor_user_area_users", force: :cascade do |t|
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.boolean "active", default: false
    t.boolean "approved", default: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.string "color"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

end
