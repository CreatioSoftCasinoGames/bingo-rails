class AddRoomConfigsIdInTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :room_config_id, :integer
  end
end
