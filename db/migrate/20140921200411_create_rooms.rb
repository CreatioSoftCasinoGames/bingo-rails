class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.decimal :min_stake
      t.decimal :max_stake
      t.decimal :min_buy_in
      t.decimal :max_buy_in
      t.integer :max_players

      t.timestamps
    end
  end
end
