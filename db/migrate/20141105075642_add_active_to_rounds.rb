class AddActiveToRounds < ActiveRecord::Migration
  def change
  	add_column :rounds, :active, :boolean, default: true
  end
end
