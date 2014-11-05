class ChangeDeckToText < ActiveRecord::Migration
  def up
    change_column :rounds, :deck, :text
  end

  def down
    change_column :rounds, :deck, :string
  end
end
