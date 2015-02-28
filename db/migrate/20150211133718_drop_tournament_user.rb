class DropTournamentUser < ActiveRecord::Migration
  def change
  	drop_table :tournament_users
  end
end
