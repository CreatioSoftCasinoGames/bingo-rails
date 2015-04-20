class ChangeDefaultInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :coins, :decimal, default: 100
  	change_column :users, :powerups_remaining, :integer, default: 5
  	change_column :users, :ticket_bought, :integer, default: 10
  end
end
