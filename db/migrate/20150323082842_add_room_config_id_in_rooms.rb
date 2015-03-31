class AddRoomConfigIdInRooms < ActiveRecord::Migration
  def change
  	add_column :rooms, :room_config_id, :integer
  end
end
