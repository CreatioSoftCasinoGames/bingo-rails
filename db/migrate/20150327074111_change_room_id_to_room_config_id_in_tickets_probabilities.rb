class ChangeRoomIdToRoomConfigIdInTicketsProbabilities < ActiveRecord::Migration
  def self.up
  	rename_column :ticket_probabilities, :room_id, :room_config_id
  end


  def self.down
  	rename_column :ticket_probabilities, :room_config_id, :room_id
  end
end
