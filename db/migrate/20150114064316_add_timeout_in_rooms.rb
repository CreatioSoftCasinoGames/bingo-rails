class AddTimeoutInRooms < ActiveRecord::Migration
  def change
  	add_column :rooms, :timeout, :decimal, default: 1000000
  end
end
