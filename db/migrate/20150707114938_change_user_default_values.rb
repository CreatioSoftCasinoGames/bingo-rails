class ChangeUserDefaultValues < ActiveRecord::Migration
  def change
  	change_column :users, :coins, :decimal, :default => 500
  	change_column :users, :ticket_bought, :integer, :default => 15
  	change_column :users, :powerups_remaining, :decimal, :default => 10
  	change_column :users, :keys, :integer, :default => 10
  end
end
