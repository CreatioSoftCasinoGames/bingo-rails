class CreateRoundUser < ActiveRecord::Migration
  def change
    create_table :round_users do |t|
    	t.integer :room_id
    	t.integer :round_id
    	t.integer :user_id
    	t.integer :daubs
    	t.integer :bingos
    	t.timestamps
    end
  end
end
