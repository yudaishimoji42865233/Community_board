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

ActiveRecord::Schema.define(version: 20200119041823) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",    null: false
    t.string   "image"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id",   null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id", using: :btree
  end

  create_table "enquetes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id",   null: false
    t.index ["topic_id"], name: "index_enquetes_on_topic_id", using: :btree
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "title",       null: false
    t.string   "content",     null: false
    t.string   "image"
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
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

  add_foreign_key "comments", "topics"
  add_foreign_key "enquetes", "topics"
  add_foreign_key "votes", "enquetes"
  add_foreign_key "votes", "users"
end
