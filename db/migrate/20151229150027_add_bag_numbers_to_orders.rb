class AddBagNumbersToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :bag_numbers, :integer, array: true, default: []
  end
end
