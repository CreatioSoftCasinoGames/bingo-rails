class SetDefaultRoundAndAttempt < ActiveRecord::Migration
  def change
  	change_column :round_users, :attempt_number, :integer, default: 1
  	change_column :round_users, :round, :integer, default: 1
  end
end
