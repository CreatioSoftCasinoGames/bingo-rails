class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.string :device_type
      t.string :version
      t.boolean :require_update

      t.timestamps
    end
  end
end
