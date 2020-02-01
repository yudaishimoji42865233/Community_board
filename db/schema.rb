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

ActiveRecord::Schema.define(version: 20200201145638) do

  create_table "comment_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "comment_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_likes_on_comment_id", using: :btree
    t.index ["user_id"], name: "index_comment_likes_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",    null: false
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id",   null: false
    t.integer  "user_id",    null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "enquetes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id",   null: false
    t.index ["topic_id"], name: "index_enquetes_on_topic_id", using: :btree
  end

  create_table "impressions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.text     "params",              limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 255 }, using: :btree
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }, using: :btree
    t.index ["user_id"], name: "index_impressions_on_user_id", using: :btree
  end

  create_table "topic_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "topic_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topic_likes_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_topic_likes_on_user_id", using: :btree
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                         null: false
    t.string   "content",                       null: false
    t.string   "image"
    t.integer  "category_id",                   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",                       null: false
    t.integer  "impressions_count", default: 0
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                null: false
    t.string   "image"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["image"], name: "index_users_on_image", using: :btree
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "enquete_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquete_id"], name: "index_votes_on_enquete_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  add_foreign_key "comment_likes", "comments"
  add_foreign_key "comment_likes", "users"
  add_foreign_key "comments", "topics"
  add_foreign_key "comments", "users"
  add_foreign_key "enquetes", "topics"
  add_foreign_key "topic_likes", "topics"
  add_foreign_key "topic_likes", "users"
  add_foreign_key "topics", "users"
  add_foreign_key "votes", "enquetes"
  add_foreign_key "votes", "users"
end
