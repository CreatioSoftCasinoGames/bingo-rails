class AddBingoCornerUser < ActiveRecord::Migration
  def change
  	add_column :users, :bingo_by_corner_pattern, :integer, default: 0
  end
end
