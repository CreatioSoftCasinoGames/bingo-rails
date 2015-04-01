class AddParentIdAndIsFbConnectedInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :parent_id, :integer, default: 0
  	add_column :users, :is_fb_connected, :boolean, default: false
  end
end
