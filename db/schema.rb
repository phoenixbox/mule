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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20140424131110) do
=======
ActiveRecord::Schema.define(version: 20140422035407) do
>>>>>>> add rooms model/controller/route

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rooms", force: true do |t|
<<<<<<< HEAD
    t.integer  "user_id",                  null: false
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        default: ""
    t.string   "style",       default: ""
    t.integer  "beds",        default: 0
    t.integer  "tables",      default: 0
    t.integer  "chairs",      default: 0
    t.integer  "electronics", default: 0
    t.integer  "accessories", default: 0
=======
    t.integer  "user_id",    null: false
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
>>>>>>> add rooms model/controller/route
  end

  add_index "rooms", ["user_id"], name: "index_rooms_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
