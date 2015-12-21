class CreateManifests < ActiveRecord::Migration
  def change
    create_table :manifests do |t|
      t.string :mawb, null: false, unique: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
