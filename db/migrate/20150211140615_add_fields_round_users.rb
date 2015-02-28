class AddFieldsRoundUsers < ActiveRecord::Migration
  def change
  	add_column :round_users, :attempt_number, :integer, default: 0
  	add_column :round_users, :round, :integer, default: 0
  end
end
