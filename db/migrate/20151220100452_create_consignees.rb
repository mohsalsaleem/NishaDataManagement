class CreateConsignees < ActiveRecord::Migration
  def change
    create_table :consignees do |t|
      t.string :name, null: false
      t.text :address_line_1, null: false
      t.text :address_line_2
      t.string :po_box_no, null: false
      t.string :city
      t.string :country, null: false
      t.string :tel_no_1, null:false
      t.string :tel_no_2
      t.string :email

      t.timestamps null: false
    end
  end
end
