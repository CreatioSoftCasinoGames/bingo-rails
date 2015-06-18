class AddValueInRewards < ActiveRecord::Migration
  def change
  	add_column :rewards, :coins, :decimal, default: 100
  	add_column :rewards, :tickets, :decimal, default: 5
  end
end
