class ChangeDataTypeOfDyanmicIaps < ActiveRecord::Migration
  def up
  	change_column :dynamic_iaps, :old_coins_value, :float
  	change_column :dynamic_iaps, :new_coins_value, :float
  	change_column :dynamic_iaps, :old_pricing, :float
  	change_column :dynamic_iaps, :new_pricing, :float
  end
end
