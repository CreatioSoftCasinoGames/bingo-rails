class ChangeTutorialDefaulValue < ActiveRecord::Migration
  def change
  	change_column :users, :show_tutorial, :boolean, :default => true
  end
end
