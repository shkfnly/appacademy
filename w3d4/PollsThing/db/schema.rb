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

ActiveRecord::Schema.define(version: 20141230221215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_choices", force: true do |t|
    t.text     "answer_text"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "polls", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "polls", ["author_id"], name: "index_polls_on_author_id", using: :btree

  create_table "questions", force: true do |t|
    t.text     "question_text"
    t.integer  "poll_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "responses", force: true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["answer_id"], name: "index_responses_on_answer_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
