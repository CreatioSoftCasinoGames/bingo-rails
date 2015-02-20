class CreateReward < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
    	t.integer :tournament_id
    	t.integer :user_id
    	t.integer :rank
    	t.boolean :is_collected, default: false
    end
  end
end
