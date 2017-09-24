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

ActiveRecord::Schema.define(version: 20170924123932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mp3s", force: :cascade do |t|
    t.string   "title"
    t.string   "interpret"
    t.string   "album"
    t.integer  "track"
    t.integer  "year"
    t.string   "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mp3s", ["title"], name: "index_mp3s_on_title", using: :btree

  create_table "playlistings", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "mp3_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "playlistings", ["mp3_id"], name: "index_playlistings_on_mp3_id", using: :btree
  add_index "playlistings", ["playlist_id"], name: "index_playlistings_on_playlist_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

  add_foreign_key "playlistings", "mp3s"
  add_foreign_key "playlistings", "playlists"
  add_foreign_key "playlists", "users"
end
