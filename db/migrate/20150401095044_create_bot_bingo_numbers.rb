class CreateBotBingoNumbers < ActiveRecord::Migration
  def change
    create_table :bot_bingo_numbers do |t|
      t.integer :number_of_bots
      t.integer :starting_number

      t.timestamps
    end
  end
end
