class ChangeColumnRoomIdToRoomConfigId < ActiveRecord::Migration
  def change
  	rename_column :tournament_users, :room_id, :room_config_id
  	rename_column :round_users, :room_id, :room_config_id
  	rename_column :rounds, :room_id, :room_config_id
  end
end
