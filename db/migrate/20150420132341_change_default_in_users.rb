class ChangeDefaultInUsers < ActiveRecord::Migration
  def self.up
  	change_column :users, :coins, :decimal, default: 100
  	change_column :users, :powerups_remaining, :integer, default: 5
  	change_column :users, :ticket_bought, :integer, default: 10
  end

  def self.down
  	change_column :users, :coins, :decimal, default: 0
  	change_column :users, :powerups_remaining, :integer, default: 0
  	change_column :users, :ticket_bought, :integer, default: 0
  end
end
