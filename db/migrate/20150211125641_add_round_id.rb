class AddRoundId < ActiveRecord::Migration
  def change
  	add_column :leader_boards, :round_id, :integer
  end
end
