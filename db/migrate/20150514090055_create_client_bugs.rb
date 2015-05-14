class CreateClientBugs < ActiveRecord::Migration
  def change
    create_table :client_bugs do |t|
      t.text :exception

      t.timestamps
    end
  end
end
