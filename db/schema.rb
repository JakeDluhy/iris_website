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

ActiveRecord::Schema.define(version: 20150123042138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instructions", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "tutorial_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "subteam_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["subteam_id"], name: "index_memberships_on_subteam_id", using: :btree
  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree
  add_index "memberships", ["user_id", "subteam_id"], name: "index_memberships_on_user_id_and_subteam_id", unique: true, using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "picture_attachments", force: true do |t|
    t.string   "avatar"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subteams", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "hook"
    t.integer  "team_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "team_id"
    t.integer  "subteam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "hook"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorials", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.integer  "team_id"
    t.integer  "subteam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "updates", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "team_id"
    t.integer  "subteam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "bio"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",              default: false
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "member_of_the_week", default: false
    t.string   "role_type"
    t.string   "role"
    t.string   "major"
    t.string   "year"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "weekly_awards", force: true do |t|
    t.string   "award_type"
    t.string   "award_description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "award_week"
  end

  create_table "workers", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["task_id"], name: "index_workers_on_task_id", using: :btree
  add_index "workers", ["user_id", "task_id"], name: "index_workers_on_user_id_and_task_id", unique: true, using: :btree
  add_index "workers", ["user_id"], name: "index_workers_on_user_id", using: :btree

end
