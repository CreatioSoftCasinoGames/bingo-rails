class CreateScratchCardRewards < ActiveRecord::Migration
  def change
    create_table :scratch_card_rewards do |t|
      t.decimal :coins, default: 0
      t.integer :powerups, default: 0
      t.integer :tickets, default: 0
      t.integer :key, default: 0
      t.integer :chest, default: 0

      t.timestamps
    end
  end
end
