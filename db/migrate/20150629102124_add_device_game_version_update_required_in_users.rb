class AddDeviceGameVersionUpdateRequiredInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :device, :string, :default => ""
  	add_column :users, :game_version, :string
  	add_column :users, :update_required, :boolean, :default => false
  end
end
