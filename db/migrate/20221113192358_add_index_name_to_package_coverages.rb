class AddIndexNameToPackageCoverages < ActiveRecord::Migration[7.0]
  def change
    add_index :package_coverages, :name, unique: true
  end
end
