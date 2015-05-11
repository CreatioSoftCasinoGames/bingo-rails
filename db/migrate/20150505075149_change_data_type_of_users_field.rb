class ChangeDataTypeOfUsersField < ActiveRecord::Migration
  def self.up
  	change_column :users, :jigsaw_data_string, :text
  	change_column :users, :achievement_data_string, :text
  end

  def self.down
  	change_column :users, :jigsaw_data_string, :string
  	change_column :users, :achievement_data_string, :string
  end
end
