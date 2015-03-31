class AddDurationInRoomConfig < ActiveRecord::Migration
  def change
  	add_column :room_configs, :duration, :integer
  end
end
