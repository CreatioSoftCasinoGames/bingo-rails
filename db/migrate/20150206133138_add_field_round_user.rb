class AddFieldRoundUser < ActiveRecord::Migration
  def change
  	add_column :round_users, :is_waiting, :boolean
  	add_column :round_users, :card_count, :integer
  end
end
