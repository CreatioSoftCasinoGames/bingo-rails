class CreateTournamentRewards < ActiveRecord::Migration
  def change
    create_table :tournament_rewards do |t|
      t.attachment :file

      t.timestamps
    end
  end
end
