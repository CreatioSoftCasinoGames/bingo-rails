class AddTestModeInClientBugs < ActiveRecord::Migration
  def change
  	add_column :client_bugs, :test_mode, :boolean, default: false
  end
end
