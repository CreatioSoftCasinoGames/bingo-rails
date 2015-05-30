class ChangeDefault < ActiveRecord::Migration
  def change
  	change_column :users, :current_level, :integer, default: 1
  end
end
