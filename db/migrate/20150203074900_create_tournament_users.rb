class CreateTournamentUsers < ActiveRecord::Migration
  def change
    create_table :tournament_users do |t|
      t.integer :tournament_id
      t.integer :user_id
      t.integer :round
      t.integer :daubs
      t.integer :bingos
      t.decimal :coins
      t.integer :attempt_number

      t.timestamps
    end
  end
end
