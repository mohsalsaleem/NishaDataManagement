class AddManifestedFlagToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :manifested_flag, :boolean
  end
end
