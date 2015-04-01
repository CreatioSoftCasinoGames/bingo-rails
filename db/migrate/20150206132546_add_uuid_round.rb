class AddUuidRound < ActiveRecord::Migration
  def change
  	add_column :rounds, :uuid, :string
  end
end
