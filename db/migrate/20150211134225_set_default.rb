class SetDefault < ActiveRecord::Migration
  def up
  	change_column :leader_boards, :score, :decimal, default: 0
  	change_column :round_users, :coins, :integer, default: 0
  end
end
