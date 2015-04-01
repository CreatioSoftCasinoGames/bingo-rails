class ChangeDataTypeOfNumBingoFactor < ActiveRecord::Migration
  def change
  	change_column :room_configs, :num_bingo_factor, :string
  end
end
