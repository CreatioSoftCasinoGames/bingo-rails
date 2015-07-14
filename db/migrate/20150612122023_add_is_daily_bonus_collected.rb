class AddIsDailyBonusCollected < ActiveRecord::Migration
  def change
  	add_column :users, :is_daily_bonus_collected, :boolean, default: true
  end
end
