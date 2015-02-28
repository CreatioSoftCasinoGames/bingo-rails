class RanameCoinsRoundUsers < ActiveRecord::Migration
  def up
  	rename_column :round_users, :coins, :score
  end
  def down
  	rename_column :round_users, :score, :coins
  end
end
