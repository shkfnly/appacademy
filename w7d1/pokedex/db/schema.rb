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

ActiveRecord::Schema.define(version: 20141105185704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokemons", force: true do |t|
    t.string   "name",       null: false
    t.integer  "attack",     null: false
    t.integer  "defense",    null: false
    t.string   "poke_type",  null: false
    t.string   "moves",      null: false
    t.string   "image_url",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "toys", force: true do |t|
    t.integer  "pokemon_id", null: false
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.integer  "happiness",  null: false
    t.string   "image_url",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "toys", ["pokemon_id"], name: "index_toys_on_pokemon_id", using: :btree

end
