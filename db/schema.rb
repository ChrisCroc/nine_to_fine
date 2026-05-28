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

ActiveRecord::Schema[8.1].define(version: 2026_05_28_150308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_categories_on_lower_name", unique: true
  end

  create_table "garments", force: :cascade do |t|
    t.string "brand"
    t.bigint "category_id", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["category_id"], name: "index_garments_on_category_id"
    t.index ["user_id"], name: "index_garments_on_user_id"
  end

  create_table "outfit_garments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "garment_id", null: false
    t.bigint "outfit_id", null: false
    t.datetime "updated_at", null: false
    t.index ["garment_id"], name: "index_outfit_garments_on_garment_id"
    t.index ["outfit_id", "garment_id"], name: "index_outfit_garments_on_outfit_and_garment", unique: true
    t.index ["outfit_id"], name: "index_outfit_garments_on_outfit_id"
  end

  create_table "outfits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index "user_id, lower((name)::text)", name: "index_outfits_on_user_id_and_lower_name", unique: true
    t.index ["user_id"], name: "index_outfits_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tag_id", null: false
    t.bigint "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id", "taggable_type", "taggable_id"], name: "index_taggings_uniqueness", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index "user_id, lower((name)::text)", name: "index_tags_on_user_id_and_lower_name", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "garments", "categories"
  add_foreign_key "garments", "users"
  add_foreign_key "outfit_garments", "garments"
  add_foreign_key "outfit_garments", "outfits"
  add_foreign_key "outfits", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "users"
end
