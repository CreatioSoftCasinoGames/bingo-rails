class AddFieldsTournamentUsers < ActiveRecord::Migration
  def change
  	add_column :tournament_users, :room_id, :integer
  	add_column :tournament_users, :card_count, :integer
  end
end
