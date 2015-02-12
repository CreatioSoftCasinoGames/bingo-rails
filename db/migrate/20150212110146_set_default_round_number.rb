class SetDefaultRoundNumber < ActiveRecord::Migration
  def change
  	change_column :round_users, :round_number, :integer, default: 0
  	remove_column :round_users, :active
  end
end
