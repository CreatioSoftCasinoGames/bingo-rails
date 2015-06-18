class AddBugTypeToClientBugs < ActiveRecord::Migration
  def change
    add_column :client_bugs, :bug_type, :text
  end
end
