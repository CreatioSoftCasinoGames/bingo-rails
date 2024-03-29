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

ActiveRecord::Schema.define(version: 20150731224827) do

  create_table "ais", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: true do |t|
    t.string   "token"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bingo_points", force: true do |t|
    t.integer  "xp",                                   default: 0
    t.decimal  "cell_coin",   precision: 10, scale: 0, default: 0
    t.decimal  "ticket_cost", precision: 10, scale: 0, default: 0
    t.integer  "theme_level",                          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bot_bingo_numbers", force: true do |t|
    t.integer  "number_of_bots"
    t.integer  "starting_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bots_probabilities", force: true do |t|
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "num_bots"
    t.float    "probability", limit: 24
    t.integer  "ai_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_bugs", force: true do |t|
    t.text     "exception"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bug_type"
    t.boolean  "test_mode",  default: false
  end

  create_table "dynamic_iaps", force: true do |t|
    t.decimal  "old_value",              precision: 10, scale: 0
    t.decimal  "new_value",              precision: 10, scale: 0
    t.float    "old_pricing", limit: 24
    t.float    "new_pricing", limit: 24
    t.boolean  "offer"
    t.string   "currency"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iap_id"
    t.string   "iap_type"
    t.boolean  "is_active",                                       default: true
    t.string   "deal_value"
    t.integer  "more"
    t.integer  "end_time"
  end

  create_table "friend_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "requested_to_id"
    t.boolean  "confirmed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_versions", force: true do |t|
    t.string   "device_type"
    t.string   "version"
    t.boolean  "require_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "send_to_id"
    t.boolean  "confirmed",                           default: false
    t.boolean  "is_asked",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gift_type",                                           null: false
    t.decimal  "gift_value", precision: 10, scale: 0, default: 5
    t.boolean  "active",                              default: true
  end

  create_table "in_app_purchases", force: true do |t|
    t.decimal  "amount",     precision: 10, scale: 0
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "level_progrations", force: true do |t|
    t.integer  "level"
    t.decimal  "xp",                precision: 10, scale: 0
    t.decimal  "xp_difference",     precision: 10, scale: 0
    t.integer  "xp_per_daub"
    t.decimal  "coins_per_bingo",   precision: 10, scale: 0
    t.integer  "tickets_per_bingo"
    t.integer  "card_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "rewards", force: true do |t|
    t.integer "tournament_id"
    t.integer "user_id"
    t.integer "rank"
    t.boolean "is_collected",                           default: false
    t.decimal "coins",         precision: 10, scale: 0, default: 100
    t.decimal "tickets",       precision: 10, scale: 0, default: 5
  end

  create_table "room_configs", force: true do |t|
    t.string   "name"
    t.string   "room_type"
    t.integer  "min_players"
    t.integer  "max_players"
    t.decimal  "timeout",          precision: 10, scale: 0, default: 1000000
    t.string   "num_bingo_factor"
    t.integer  "divider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
  end

  create_table "room_users", force: true do |t|
    t.integer  "daubs"
    t.integer  "bingos"
    t.boolean  "is_waiting"
    t.integer  "cards_count"
    t.integer  "attempt_no",                           default: 1
    t.integer  "round_no",                             default: 0
    t.decimal  "score",       precision: 10, scale: 0, default: 0
    t.boolean  "over",                                 default: false
    t.integer  "room_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
    t.decimal  "timeout",          precision: 10, scale: 0, default: 1000000
    t.string   "num_bingo_factor"
    t.integer  "divider"
    t.integer  "room_config_id"
    t.integer  "round_number"
    t.string   "uuid"
  end

  create_table "round_users", force: true do |t|
    t.integer  "room_config_id"
    t.integer  "round_id"
    t.integer  "user_id"
    t.integer  "daubs"
    t.integer  "bingos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_waiting"
    t.integer  "card_count"
    t.integer  "score",          default: 0
    t.integer  "attempt_number", default: 1
    t.integer  "round_number",   default: 0
    t.integer  "tournament_id"
  end

  create_table "rounds", force: true do |t|
    t.integer  "room_config_id"
    t.integer  "num_players"
    t.text     "deck"
    t.integer  "num_cards"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",         default: true
    t.string   "uuid"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

  create_table "scratch_card_rewards", force: true do |t|
    t.decimal  "coins",      precision: 10, scale: 0, default: 0
    t.integer  "powerups",                            default: 0
    t.integer  "tickets",                             default: 0
    t.integer  "key",                                 default: 0
    t.integer  "chest",                               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_probabilities", force: true do |t|
    t.integer  "num_ticket"
    t.float    "probability",    limit: 24
    t.integer  "room_config_id"
    t.integer  "ai_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_rewards", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.integer  "room_config_id"
    t.decimal  "score",          precision: 10, scale: 0, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "over",                                    default: false
    t.decimal  "rank",           precision: 10, scale: 0
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tournament_type"
    t.boolean  "active",          default: true
    t.integer  "room_config_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                            default: "",       null: false
    t.string   "encrypted_password",                                               default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                    default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                                                             default: "PLAYER"
    t.boolean  "is_guest"
    t.decimal  "tokens",                                  precision: 10, scale: 0, default: 0
    t.decimal  "coins",                                   precision: 10, scale: 0, default: 500
    t.decimal  "powerups_remaining",                      precision: 10, scale: 0, default: 10
    t.integer  "keys",                                                             default: 10
    t.integer  "bingo_win",                                                        default: 0
    t.integer  "tickets_purchased",                                                default: 0
    t.integer  "current_level",                                                    default: 1
    t.integer  "xp_earned",                                                        default: 0
    t.decimal  "achievements_won",                        precision: 10, scale: 0, default: 0
    t.decimal  "jigsaw_pieces_collected",                 precision: 10, scale: 0, default: 0
    t.integer  "total_daubs",                                                      default: 0
    t.integer  "powerups_used",                                                    default: 0
    t.integer  "bingo_played",                                                     default: 0
    t.integer  "ticket_bought",                                                    default: 10
    t.integer  "tournaments_participated",                                         default: 0
    t.integer  "tournaments_won",                                                  default: 0
    t.integer  "best_tournament_position",                                         default: 0
    t.integer  "best_bingo_position",                                              default: 0
    t.integer  "daily_free_tickets_available",                                     default: 0
    t.integer  "bounus_coins_and_tickets",                                         default: 0
    t.integer  "mystery_chests_opened",                                            default: 0
    t.integer  "free_daubs_collected",                                             default: 0
    t.integer  "keys_collected_in_game",                                           default: 0
    t.integer  "bingo_by_vertical_pattern",                                        default: 0
    t.integer  "bingo_by_horizontal_pattern",                                      default: 0
    t.integer  "bingo_by_diagonal_pattern",                                        default: 0
    t.integer  "coins_collected_in_game",                                          default: 0
    t.boolean  "is_invited_facebook_friend",                                       default: false
    t.boolean  "is_gifted_to_friend",                                              default: false
    t.boolean  "is_bingo_on_all_card",                                             default: false
    t.decimal  "fastest_bingo",                           precision: 10, scale: 0, default: 0
    t.string   "device_id"
    t.integer  "bingo_by_corner_pattern",                                          default: 0
    t.string   "login_token"
    t.boolean  "is_bot",                                                           default: false
    t.boolean  "online",                                                           default: false
    t.integer  "parent_id",                                                        default: 0
    t.boolean  "is_fb_connected",                                                  default: false
    t.integer  "total_jigsaw_completed",                                           default: 0
    t.integer  "total_daily_participitated",                                       default: 0
    t.integer  "total_weekly_participated",                                        default: 0
    t.integer  "total_card_used",                                                  default: 0
    t.integer  "total_monthly_participated",                                       default: 0
    t.integer  "total_daily_won",                                                  default: 0
    t.integer  "total_weekly_won",                                                 default: 0
    t.text     "jigsaw_data_string"
    t.integer  "total_monthly_won",                                                default: 0
    t.text     "achievement_data_string"
    t.integer  "best_daily_position",                                              default: 0
    t.integer  "best_monthly_position",                                            default: 0
    t.integer  "best_weekly_position",                                             default: 0
    t.integer  "best_special_position",                                            default: 0
    t.decimal  "total_free_spin_count",                   precision: 10, scale: 0, default: 5
    t.decimal  "total_scratch_count",                     precision: 10, scale: 0, default: 5
    t.decimal  "daily_bonus_time_remaining",              precision: 10, scale: 0, default: 0
    t.decimal  "special_reward_timer",                    precision: 10, scale: 0, default: 0
    t.integer  "total_room_unlocked",                                              default: 0
    t.integer  "total_bingo",                                                      default: 0
    t.boolean  "is_daily_bonus_collected",                                         default: true
    t.string   "country",                                                          default: ""
    t.boolean  "show_tutorial",                                                    default: true
    t.boolean  "daily_fee_paid",                                                   default: false
    t.boolean  "weekly_fee_paid",                                                  default: false
    t.boolean  "monthly_fee_paid",                                                 default: false
    t.string   "device",                                                           default: ""
    t.string   "game_version"
    t.boolean  "update_required",                                                  default: false
    t.string   "unique_id",                                                        default: ""
    t.float    "total_iap_made",               limit: 24,                          default: 0.0
    t.string   "currency",                                                         default: "USD"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 2147483647
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
