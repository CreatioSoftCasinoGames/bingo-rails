class AddCurrencyInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :currency, :string, default: "USD"
  end
end
