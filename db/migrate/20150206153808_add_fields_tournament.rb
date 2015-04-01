class AddFieldsTournament < ActiveRecord::Migration
  def change
  	add_column :tournaments, :tournament_type, :string
  	add_column :tournaments, :num_player, :integer
  	add_column :tournaments, :deck, :text
  	add_column :tournaments, :num_cards, :integer
  	add_column :tournaments, :active, :boolean, default: true
  	add_column :tournaments, :uuid, :string
  end
end
