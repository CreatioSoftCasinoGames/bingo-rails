class AddGiftTypeInGiftRequest < ActiveRecord::Migration
  def change
  	add_column :gift_requests, :gift_type, :string, null: false
  end
end
