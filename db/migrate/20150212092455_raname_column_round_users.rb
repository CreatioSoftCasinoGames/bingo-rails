class RanameColumnRoundUsers < ActiveRecord::Migration
  def change
  	rename_column :round_users, :round, :round_number
  end
end
