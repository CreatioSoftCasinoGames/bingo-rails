class CreateTicketProbabilities < ActiveRecord::Migration
  def change
    create_table :ticket_probabilities do |t|
      t.integer :num_ticket
      t.float :probability
      t.integer :room_id
      t.integer :ai_id

      t.timestamps
    end
  end
end
