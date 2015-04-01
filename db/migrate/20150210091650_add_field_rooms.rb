class AddFieldRooms < ActiveRecord::Migration
  def change
  	add_column :rooms, :num_bingo_factor, :string
  	add_column :rooms, :divider, :integer
  end
end
