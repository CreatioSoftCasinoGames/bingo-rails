class AddFieldIsWaiting < ActiveRecord::Migration
  def change
  	add_column :tournament_users, :is_waiting, :boolean, default: true
  end
end
