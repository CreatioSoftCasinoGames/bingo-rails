class AddCoinsRoundUsers < ActiveRecord::Migration
  def change
  	add_column :round_users, :coins, :integer
  end
end
