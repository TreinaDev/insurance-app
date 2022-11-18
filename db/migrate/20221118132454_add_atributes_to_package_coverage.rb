class AddAtributesToPackageCoverage < ActiveRecord::Migration[7.0]
  def change
    add_column :package_coverages, :status, :integer, default: 0
    add_column :package_coverages, :code, :string
    add_index :package_coverages, :code, unique: true
  end
end
