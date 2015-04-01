class RenameLeaderBoard < ActiveRecord::Migration
  def up
  	rename_table :leader_boards, :tournament_users
  end
  def down
  	rename_table :tournament_users, :leader_boards
  end
end
