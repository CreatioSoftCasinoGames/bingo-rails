class CreateInAppPurchases < ActiveRecord::Migration
  def change
    create_table :in_app_purchases do |t|
    	t.decimal :amount
    	t.string :title
    	t.integer :user_id
    	t.timestamps
    end
  end
end
