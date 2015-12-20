class AddBaggageDataToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :baggage_data, :hstore
  end
end
