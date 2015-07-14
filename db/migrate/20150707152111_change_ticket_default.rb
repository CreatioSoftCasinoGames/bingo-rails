class ChangeTicketDefault < ActiveRecord::Migration
  def change
  	change_column :users, :ticket_bought, :integer, :default => 10
  end
end
