class RenameFieldsValueOfDynamicIaps < ActiveRecord::Migration
  def up
  	rename_column :dynamic_iaps, :old_coins_value, :old_value
  	rename_column :dynamic_iaps, :new_coins_value, :new_value
  end
  def down
  	rename_column :dynamic_iaps, :old_value, :old_coins_value
  	rename_column :dynamic_iaps, :new_value, :new_coins_value
  end
end
