class RemovePackageFromCoveragePricing < ActiveRecord::Migration[7.0]
  def change
    remove_reference :coverage_pricings, :package, null: false, foreign_key: true
  end
end
