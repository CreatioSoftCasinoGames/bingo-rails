class ModifyFields < ActiveRecord::Migration
  def change
  	add_column :round_users, :active, :boolean, default: true
  	add_column :tournament_users, :over, :boolean, default: false
  	add_column :tournament_users, :rank, :decimal
  	remove_column :tournament_users, :round_id
  end
end
