class AddTotalBingoInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :total_bingo, :integer, default: 0
  end
end
