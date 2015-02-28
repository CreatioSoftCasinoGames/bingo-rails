class RenameNumPlayers < ActiveRecord::Migration
  def up
  	rename_column :tournaments, :num_player, :num_players
  end
  def down
  	rename_column :tournaments, :num_players, :num_player
  end
end
