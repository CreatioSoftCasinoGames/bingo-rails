class AddFieldsInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :daily_fee_paid, :boolean, :default => false
  	add_column :users, :weekly_fee_paid, :boolean, :default => false
  	add_column :users, :monthly_fee_paid, :boolean, :default => false
  end
end
