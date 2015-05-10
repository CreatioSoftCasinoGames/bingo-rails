class DeleteTotalBingoFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :total_bing
  end
end
