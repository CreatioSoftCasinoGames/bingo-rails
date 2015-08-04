class CreateLevelProgrations < ActiveRecord::Migration
  def change
    create_table :level_progrations do |t|
      t.integer :level
      t.decimal :xp
      t.decimal :xp_difference
      t.integer :xp_per_daub
      t.decimal :coins_per_bingo
      t.integer :tickets_per_bingo
      t.integer :card_cost

      t.timestamps
    end
  end
end
