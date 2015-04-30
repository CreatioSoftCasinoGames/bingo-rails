class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|
      t.integer :daubs
      t.integer :bingos
      t.boolean :is_waiting
      t.integer :cards_count
      t.integer :attempt_no,        default: 1
      t.integer :round_no,          default: 0
      t.decimal :score,             default: 0
      t.boolean :over,              default: false
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end




