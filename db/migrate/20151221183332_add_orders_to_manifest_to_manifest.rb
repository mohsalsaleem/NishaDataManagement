class AddOrdersToManifestToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :orders_to_manifest, :integer, array: true, default: []
  end
end
