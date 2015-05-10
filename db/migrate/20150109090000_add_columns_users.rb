class AddColumnsUsers < ActiveRecord::Migration
  def change
  	add_column :users, :tokens, :decimal, default: 0
  	add_column :users, :coins, :decimal, default: 0
  	add_column :users, :powerups_remaining, :integer, default: 30
  	add_column :users, :keys, :integer, default: 20
  	add_column :users, :bingo_win, :integer, default: 0
  	add_column :users, :tickets_purchased, :integer, default: 0
  	add_column :users, :current_level, :integer, default: 0
  	add_column :users, :xp_earned, :integer, default: 0
  	add_column :users, :achievements_won, :decimal, default: 0
  	add_column :users, :jigsaw_pieces_collected, :decimal, default: 0
  	add_column :users, :total_daubs, :integer, default: 0
  	add_column :users, :powerups_used, :integer, default: 0
  	add_column :users, :bingo_played, :integer, default: 0
  	add_column :users, :ticket_bought, :integer, default: 0
  	add_column :users, :tournaments_participated, :integer, default: 0
  	add_column :users, :tournaments_won, :integer, default: 0
  	add_column :users, :best_tournament_position, :integer, default: 0
    add_column :users, :best_bingo_position, :integer, default: 0
  	add_column :users, :daily_free_tickets_available, :integer, default: 0
  	add_column :users, :bounus_coins_and_tickets, :integer, default: 0
  	add_column :users, :mystery_chests_opened, :integer, default: 0
  	add_column :users, :free_daubs_collected, :integer, default: 0
  	add_column :users, :keys_collected_in_game, :integer, default: 0
  	add_column :users, :bingo_by_vertical_pattern, :integer, default: 0
  	add_column :users, :bingo_by_horizontal_pattern, :integer, default: 0
  	add_column :users, :bingo_by_diagonal_pattern, :integer, default: 0
  	add_column :users, :coins_collected_in_game, :integer, default: 0
  	add_column :users, :is_invited_facebook_friend, :boolean, default: 0
  	add_column :users, :is_gifted_to_friend, :boolean, default: 0
  	add_column :users, :is_bingo_on_all_card, :boolean, default: 0
  	add_column :users, :fastest_bingo, :decimal, default: 0

  end

end
