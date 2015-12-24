class AddDefaultToManifestedFlagInOrders < ActiveRecord::Migration
  def change
	change_column :orders, :manifested_flag, :boolean, default: false
  end
end
