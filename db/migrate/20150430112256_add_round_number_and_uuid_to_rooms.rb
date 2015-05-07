class AddRoundNumberAndUuidToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :round_number, :integer
    add_column :rooms, :uuid, :string
  end
end
