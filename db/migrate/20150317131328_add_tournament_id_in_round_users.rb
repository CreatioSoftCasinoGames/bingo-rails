class AddTournamentIdInRoundUsers < ActiveRecord::Migration
  def change
  	add_column :round_users, :tournament_id, :integer
  end
end
