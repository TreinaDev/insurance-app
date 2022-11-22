class AddIndexToCoveragePricing < ActiveRecord::Migration[7.0]
  def change
    add_index :coverage_pricings, [:package_coverage_id, :package_id], unique: true
  end
end
