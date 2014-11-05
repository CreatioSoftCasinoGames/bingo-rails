class AddUserInfo < ActiveRecord::Migration
  def change
  	add_column :users, :fb_id, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :role, :string, default: "PLAYER"
  	add_column :users, :is_guest, :boolean
  end
end
