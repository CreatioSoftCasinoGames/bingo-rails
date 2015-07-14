class AddEndTimeInDynamicIapsForSpecialDeal < ActiveRecord::Migration
  def change
  	add_column :dynamic_iaps, :end_time, :integer
  end
end
