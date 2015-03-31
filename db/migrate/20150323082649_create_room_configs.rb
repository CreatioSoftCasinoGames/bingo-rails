class CreateRoomConfigs < ActiveRecord::Migration
  def change
    create_table :room_configs do |t|
      t.string :name
      t.string :type
      t.integer :min_players
      t.integer :max_players
      t.decimal :timeout, default: 1000000
      t.integer :num_bingo_factor
      t.integer :divider

      t.timestamps
    end
  end
end
