class AddFieldsInDynamicIap < ActiveRecord::Migration
  def change
  	add_column :dynamic_iaps, :more, :integer
  end
end
