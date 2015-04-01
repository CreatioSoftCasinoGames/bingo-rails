class AddRoundResource < ActiveRecord::Migration
  def change
  	add_column :rounds, :resource_id, :integer
  	add_column :rounds, :resource_type, :string
  	add_column :rounds, :bundle_type, :string
  end
end
