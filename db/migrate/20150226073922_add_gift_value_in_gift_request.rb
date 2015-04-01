class AddGiftValueInGiftRequest < ActiveRecord::Migration
  def change
  	add_column :gift_requests, :gift_value, :decimal, default: 5
  end
end
