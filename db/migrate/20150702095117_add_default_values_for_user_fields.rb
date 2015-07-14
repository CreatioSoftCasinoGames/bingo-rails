class AddDefaultValuesForUserFields < ActiveRecord::Migration
  def up
  	change_column :users, :total_free_spin_count, :decimal, default: 5
  	change_column :users, :total_scratch_count, :decimal, default: 5
  end
  def down
  	change_column :users, :total_free_spin_count, :decimal, default: 0
  	change_column :users, :total_scratch_count, :decimal, default: 0
  end
end
