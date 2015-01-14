class AddUserIdPowerups < ActiveRecord::Migration
  def change
  	add_column :powerups, :user_id, :integer
  end
end
