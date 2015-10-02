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

ActiveRecord::Schema.define(version: 20150922140842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"

  create_table "categories", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name"
    t.string   "subcats",     default: [],              array: true
    t.string   "filterables", default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "catsubs", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "subcate_id"
  end

  create_table "connections", id: false, force: :cascade do |t|
    t.integer "store_id"
  end

  create_table "favourites", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "store_id"
  end

  create_table "monologue_posts", force: :cascade do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
  end

  add_index "monologue_posts", ["url"], name: "index_monologue_posts_on_url", unique: true, using: :btree

  create_table "monologue_taggings", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], name: "index_monologue_taggings_on_post_id", using: :btree
  add_index "monologue_taggings", ["tag_id"], name: "index_monologue_taggings_on_tag_id", using: :btree

  create_table "monologue_tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "monologue_tags", ["name"], name: "index_monologue_tags_on_name", using: :btree

  create_table "monologue_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "mrp"
    t.decimal  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["product_id"], name: "index_order_details_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "logistic_id"
    t.integer  "quantity"
    t.decimal  "ordervalue"
    t.text     "address"
    t.integer  "bresponse"
    t.integer  "sresponse"
    t.integer  "lresponse"
    t.boolean  "bvis"
    t.boolean  "svis"
    t.boolean  "lvis"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "orders", ["logistic_id"], name: "index_orders_on_logistic_id", using: :btree
  add_index "orders", ["store_id"], name: "index_orders_on_store_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name",       default: "",    null: false
    t.string   "brand"
    t.string   "image"
    t.string   "unit"
    t.decimal  "price",      default: 100.0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "stock"
    t.hstore   "specs"
    t.integer  "category"
  end

  add_index "products", ["store_id"], name: "index_products_on_store_id", using: :btree

  create_table "store_products", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.decimal  "price",       default: 100.0, null: false
    t.integer  "stock",       default: 100,   null: false
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "store_products", ["product_id"], name: "index_store_products_on_product_id", using: :btree
  add_index "store_products", ["store_id"], name: "index_store_products_on_store_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "image"
    t.text     "detail"
    t.text     "offer"
    t.string   "state",       default: "",    null: false
    t.string   "city",        default: "",    null: false
    t.string   "zip"
    t.string   "add1",        default: "",    null: false
    t.string   "add2"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "subcription"
    t.boolean  "enable",      default: true,  null: false
    t.text     "oparea"
    t.integer  "opradius"
    t.integer  "referer"
    t.decimal  "thrusold",    default: 100.0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "storetype"
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "trackings", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user"
    t.text     "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trackings", ["order_id"], name: "index_trackings_on_order_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "state",                  default: "", null: false
    t.string   "city",                   default: "", null: false
    t.integer  "zip"
    t.string   "add1",                   default: "", null: false
    t.string   "add2"
    t.integer  "contact",                default: 0,  null: false
    t.integer  "contact2"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "user_tnc"
    t.boolean  "service_tnc"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscription",           default: 0
    t.integer  "coins",                  default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
