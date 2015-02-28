class AddFieldRounds < ActiveRecord::Migration
  def change
  	add_column :rounds, :resource_type, :string
  	add_column :rounds, :resource_id, :integer
  end
end
