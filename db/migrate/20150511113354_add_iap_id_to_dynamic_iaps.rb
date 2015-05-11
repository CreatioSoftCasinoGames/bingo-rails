class AddIapIdToDynamicIaps < ActiveRecord::Migration
  def change
    add_column :dynamic_iaps, :iap_id, :string
  end
end
