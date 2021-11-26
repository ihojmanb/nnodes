# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_26_171220) do

  create_table "bets", force: :cascade do |t|
    t.integer "amount"
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color"
    t.integer "round_id"
    t.index ["player_id", "created_at"], name: "index_bets_on_player_id_and_created_at"
    t.index ["player_id"], name: "index_bets_on_player_id"
    t.index ["round_id"], name: "index_bets_on_round_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "balance", default: 10000
    t.integer "roulette_id"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["roulette_id"], name: "index_players_on_roulette_id"
  end

  create_table "roulettes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "result"
    t.integer "actual_round_id"
    t.float "temperature"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "roulette_id"
    t.index ["roulette_id"], name: "index_rounds_on_roulette_id"
  end

  add_foreign_key "bets", "players"
  add_foreign_key "bets", "rounds"
  add_foreign_key "players", "roulettes"
  add_foreign_key "rounds", "roulettes"
end
