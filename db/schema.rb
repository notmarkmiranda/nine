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

ActiveRecord::Schema.define(version: 20180107170133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "season_id"
    t.integer "attendees"
    t.integer "buy_in"
    t.bigint "user_id"
    t.boolean "privated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "finalized", default: false
    t.index ["season_id"], name: "index_games_on_season_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "user_id"
    t.boolean "privated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "completed", default: false
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_seasons_on_league_id"
  end

  create_table "user_league_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "league_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_user_league_roles_on_league_id"
    t.index ["user_id"], name: "index_user_league_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.boolean "invited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "games", "seasons"
  add_foreign_key "games", "users"
  add_foreign_key "leagues", "users"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "user_league_roles", "leagues"
  add_foreign_key "user_league_roles", "users"
end
