class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :room_id

      t.timestamps
    end
  end
end
