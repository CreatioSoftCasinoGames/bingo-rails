class CreateAis < ActiveRecord::Migration
  def change
    create_table :ais do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
