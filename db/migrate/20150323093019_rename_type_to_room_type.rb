class RenameTypeToRoomType < ActiveRecord::Migration
  def change
  	rename_column :room_configs, :type, :room_type
  end
end
