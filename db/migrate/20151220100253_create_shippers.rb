class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :name, null: false
      t.text :address_line_1, null: false
      t.text :address_line_2
      t.string :city
      t.string :country, null: false
      t.string :tel_no, null: false
      t.string :email

      t.timestamps null: false
    end
  end
end
