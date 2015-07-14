class ChangeDefaultValuesForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :coins, :decimal, :default => 200
  	change_column :users, :ticket_bought, :integer, :default => 25
  end
end
