class SetDefaultTournamentUser < ActiveRecord::Migration
  def change
  	change_column :tournament_users, :attempt_number, :integer, default: 1
  	change_column :tournament_users, :round, :integer, default: 1
  end
end
