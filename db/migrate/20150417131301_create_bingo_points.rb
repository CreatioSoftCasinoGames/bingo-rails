class CreateBingoPoints < ActiveRecord::Migration
  def change
    create_table :bingo_points do |t|
      t.integer :xp, default: 0
      t.decimal :cell_coin, default: 0
      t.decimal :ticket_cost, default: 0
      t.integer :theme_level, default: 0

      t.timestamps
    end
  end
end
