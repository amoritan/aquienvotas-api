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

ActiveRecord::Schema.define(version: 2018_12_25_231150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "ballots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 2, default: 1
    t.datetime "expires_at"
    t.uuid "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_ballots_on_province_id"
  end

  create_table "ballots_candidates", id: false, force: :cascade do |t|
    t.uuid "ballot_id"
    t.uuid "candidate_id"
    t.index ["ballot_id"], name: "index_ballots_candidates_on_ballot_id"
    t.index ["candidate_id"], name: "index_ballots_candidates_on_candidate_id"
  end

  create_table "candidates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "color", limit: 6
    t.integer "status", limit: 2, default: 1
    t.uuid "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_candidates_on_party_id"
  end

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "origin_id", limit: 6
    t.uuid "province_id"
    t.index ["origin_id"], name: "index_cities_on_origin_id", unique: true
    t.index ["province_id"], name: "index_cities_on_province_id"
  end

  create_table "parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "color", limit: 6
    t.integer "status", limit: 2, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poll_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "color", limit: 6
    t.integer "status", limit: 2, default: 1
    t.uuid "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_poll_options_on_poll_id"
  end

  create_table "polls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 2, default: 1
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "origin_id", limit: 6
    t.index ["origin_id"], name: "index_provinces_on_origin_id", unique: true
  end

  add_foreign_key "ballots", "provinces"
  add_foreign_key "ballots_candidates", "ballots"
  add_foreign_key "ballots_candidates", "candidates"
  add_foreign_key "candidates", "parties"
  add_foreign_key "cities", "provinces"
  add_foreign_key "poll_options", "polls"
end
