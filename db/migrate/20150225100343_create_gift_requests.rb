class CreateGiftRequests < ActiveRecord::Migration
  def change
    create_table :gift_requests do |t|
      t.integer :user_id
      t.integer :send_to_id
      t.boolean :confirmed, default: false
      t.boolean :is_asked, default: false

      t.timestamps
    end
  end
end
