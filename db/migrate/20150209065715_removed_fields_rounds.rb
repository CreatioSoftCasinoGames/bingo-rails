class RemovedFieldsRounds < ActiveRecord::Migration
  def up
  	remove_column :rounds, :resource_id
  	remove_column :rounds, :resource_type
  	remove_column :rounds, :bundle_type
  end
  def down
  	add_column :rounds, :resource_id, :integer
  	add_column :rounds, :resource_type, :string
  	add_column :rounds, :bundle_type, :string
  end
end
