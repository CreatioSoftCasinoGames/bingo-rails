class RemoveFieldsTournament < ActiveRecord::Migration
  def change
  	remove_column :tournaments, :num_players
  	remove_column :tournaments, :deck
  	remove_column :tournaments, :num_cards
  	remove_column :tournaments, :uuid
  end
end
