class AddTotalIapMadeAndUniqueIdInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :unique_id, :string, :default => ""
  	add_column :users, :total_iap_made, :float, :default => 0.0
  end
end
