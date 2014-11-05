class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :room_id
      t.integer :num_players
      t.string :deck
      t.integer :num_cards

      t.timestamps
    end
  end
end
