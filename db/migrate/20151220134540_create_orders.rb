class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :hawb_number
      t.references :shipper, index: true, foreign_key: true
      t.references :consignee, index: true, foreign_key: true
      t.integer :total_pieces
      t.decimal :total_weight
      t.decimal :items_cost
      t.text :content

      t.timestamps null: false
    end
  end
end
