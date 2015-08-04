class AddActiveInGiftRequests < ActiveRecord::Migration
  def change
  	add_column :gift_requests, :active, :boolean, default: true
  end
end
