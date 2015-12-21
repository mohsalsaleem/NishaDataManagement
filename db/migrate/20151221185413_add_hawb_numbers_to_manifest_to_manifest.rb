class AddHawbNumbersToManifestToManifest < ActiveRecord::Migration
  def change
    add_column :manifests, :hawb_numbers_to_manifest, :string, array: true, default: []
  end
end
