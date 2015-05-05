class ChangeDataTypeOfUsersField < ActiveRecord::Migration
  def change
  	change_column :users, :jigsaw_data_string, :text
  	change_column :users, :achievement_data_string, :text
  end
end
