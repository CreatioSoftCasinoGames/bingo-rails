class CreatePowerups < ActiveRecord::Migration
  def change
    create_table :powerups do |t|
    	t.integer :free_cell
    	t.integer :instant_bingo
    	t.integer :mystry_chests
    	t.integer :reveal_and_daub
    	t.integer :double_payout
    	t.integer :free_coins
    end
  end
end
