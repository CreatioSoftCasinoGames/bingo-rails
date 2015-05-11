class DeleteTotalBingoFromUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :total_bingo
  end

  def self.down
  	add_column :users, :total_bingo, :integer
  end
end
