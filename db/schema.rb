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

ActiveRecord::Schema.define(version: 2019_02_15_115556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ballots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "status", limit: 2, default: 1
    t.datetime "expires_at"
    t.uuid "province_id"
    t.jsonb "results", default: {}
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

  create_table "locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "population"
    t.jsonb "demographics", default: {"male"=>[0, 0, 0, 0, 0], "female"=>[0, 0, 0, 0, 0]}
    t.uuid "province_id"
    t.index ["province_id"], name: "index_locations_on_province_id"
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
    t.string "code", limit: 4
    t.index ["code"], name: "index_provinces_on_code", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "account_id"
    t.string "access_token"
    t.datetime "access_token_expires_at"
    t.uuid "location_id"
    t.integer "gender", limit: 2
    t.integer "age", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "voting_type"
    t.uuid "voting_id"
    t.string "choice_type"
    t.uuid "choice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_type", "choice_id"], name: "index_votes_on_choice_type_and_choice_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["voting_type", "voting_id"], name: "index_votes_on_voting_type_and_voting_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ballots", "provinces"
  add_foreign_key "ballots_candidates", "ballots"
  add_foreign_key "ballots_candidates", "candidates"
  add_foreign_key "candidates", "parties"
  add_foreign_key "locations", "provinces"
  add_foreign_key "poll_options", "polls"
  add_foreign_key "users", "locations"
  add_foreign_key "votes", "users"
end
