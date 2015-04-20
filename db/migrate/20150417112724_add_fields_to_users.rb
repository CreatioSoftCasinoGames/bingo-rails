class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :total_jigsaw_completed, :integer, default: 0
  	add_column :users, :total_bingo, :integer, default: 0
  	add_column :users, :total_daily_participitated, :integer, default: 0
  	add_column :users, :total_weekly_participated, :integer, default: 0
  	add_column :users, :total_card_used, :integer, default: 0
  	add_column :users, :total_monthly_participated, :integer, default: 0
  	add_column :users, :total_daily_won, :integer, default: 0

  	add_column :users, :total_weekly_won, :integer, default: 0
  	add_column :users, :jigsaw_data_string, :string
  	add_column :users, :total_monthly_won, :integer, default: 0
  	add_column :users, :achievement_data_string, :string


  	add_column :users, :best_daily_position, :integer, default: 0
  	add_column :users, :best_monthly_position, :integer, default: 0
  	add_column :users, :best_weekly_position, :integer, default: 0
  	add_column :users, :best_special_position, :integer, default: 0
  	add_column :users, :total_free_spin_count, :integer, default: 0

  	add_column :users, :total_scratch_count, :integer, default: 0
  	add_column :users, :daily_bonus_time_remaining, :decimal, default: 0
  	add_column :users, :special_reward_timer, :decimal, default: 0
  	add_column :users, :total_room_unlocked, :integer, default: 0


  end
end
