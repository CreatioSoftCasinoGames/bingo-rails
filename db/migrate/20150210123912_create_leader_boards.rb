class CreateLeaderBoards < ActiveRecord::Migration
  def change
    create_table :leader_boards do |t|
      t.integer :user_id
      t.integer :tournament_id
      t.integer :room_id
      t.decimal :score

      t.timestamps
    end
  end
end
