class AddShowTutorialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_tutorial, :boolean, default: false
  end
end
