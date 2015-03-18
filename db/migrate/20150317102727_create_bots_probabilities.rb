class CreateBotsProbabilities < ActiveRecord::Migration
  def change
    create_table :bots_probabilities do |t|
      t.integer :min_players
      t.integer :max_players
      t.integer :num_bots
      t.float :probability
      t.integer :ai_id

      t.timestamps
    end
  end
end
