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

ActiveRecord::Schema.define(version: 20150211125641) do

  create_table "api_keys", force: true do |t|
    t.string   "token"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "in_app_purchases", force: true do |t|
    t.decimal  "amount",     precision: 10, scale: 0
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leader_boards", force: true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.integer  "room_id"
    t.decimal  "score",         precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  create_table "login_histories", force: true do |t|
    t.boolean  "active"
    t.integer  "user_id"
    t.string   "login_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "powerups", force: true do |t|
    t.integer "free_cell"
    t.integer "instant_bingo"
    t.integer "mystry_chests"
    t.integer "reveal_and_daub"
    t.integer "double_payout"
    t.integer "free_coins"
    t.integer "user_id"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
    t.decimal  "timeout",          precision: 10, scale: 0, default: 1000000
    t.string   "num_bingo_factor"
    t.integer  "divider"
  end

  create_table "round_users", force: true do |t|
    t.integer  "room_id"
    t.integer  "round_id"
    t.integer  "user_id"
    t.integer  "daubs"
    t.integer  "bingos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_waiting"
    t.integer  "card_count"
  end

  create_table "rounds", force: true do |t|
    t.integer  "room_id"
    t.integer  "num_players"
    t.text     "deck"
    t.integer  "num_cards"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        default: true
    t.string   "uuid"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

  create_table "tournament_users", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.integer  "round",                                   default: 1
    t.integer  "daubs"
    t.integer  "bingos"
    t.decimal  "coins",          precision: 10, scale: 0
    t.integer  "attempt_number",                          default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_id"
    t.integer  "card_count"
    t.boolean  "is_waiting",                              default: true
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tournament_type"
    t.integer  "num_players"
    t.text     "deck"
    t.integer  "num_cards"
    t.boolean  "active",          default: true
    t.string   "uuid"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                 default: "",       null: false
    t.string   "encrypted_password",                                    default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                                                  default: "PLAYER"
    t.boolean  "is_guest"
    t.decimal  "tokens",                       precision: 10, scale: 0, default: 0
    t.decimal  "coins",                        precision: 10, scale: 0, default: 0
    t.integer  "powerups_remaining",                                    default: 30
    t.integer  "keys",                                                  default: 20
    t.integer  "bingo_win",                                             default: 0
    t.integer  "tickets_purchased",                                     default: 0
    t.integer  "current_level",                                         default: 0
    t.integer  "xp_earned",                                             default: 0
    t.decimal  "achievements_won",             precision: 10, scale: 0, default: 0
    t.decimal  "jigsaw_pieces_collected",      precision: 10, scale: 0, default: 0
    t.integer  "total_daubs",                                           default: 0
    t.integer  "powerups_used",                                         default: 0
    t.integer  "bingo_played",                                          default: 0
    t.integer  "ticket_bought",                                         default: 0
    t.integer  "tournaments_participated",                              default: 0
    t.integer  "tournaments_won",                                       default: 0
    t.integer  "best_tournament_position",                              default: 0
    t.integer  "best_bingo_position",                                   default: 0
    t.integer  "daily_free_tickets_available",                          default: 0
    t.integer  "bounus_coins_and_tickets",                              default: 0
    t.integer  "mystery_chests_opened",                                 default: 0
    t.integer  "free_daubs_collected",                                  default: 0
    t.integer  "keys_collected_in_game",                                default: 0
    t.integer  "bingo_by_vertical_pattern",                             default: 0
    t.integer  "bingo_by_horizontal_pattern",                           default: 0
    t.integer  "bingo_by_diagonal_pattern",                             default: 0
    t.integer  "coins_collected_in_game",                               default: 0
    t.boolean  "is_invited_facebook_friend",                            default: false
    t.boolean  "is_gifted_to_friend",                                   default: false
    t.boolean  "is_bingo_on_all_card",                                  default: false
    t.decimal  "fastest_bingo",                precision: 10, scale: 0, default: 0
    t.string   "device_id"
    t.integer  "bingo_by_corner_pattern",                               default: 0
    t.string   "login_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
