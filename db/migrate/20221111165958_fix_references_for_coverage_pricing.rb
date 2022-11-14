class FixReferencesForCoveragePricing < ActiveRecord::Migration[7.0]
  def change
    remove_reference :coverage_pricings, :coverage, index: true
    add_reference :coverage_pricings, :package_coverage, foreign_key: true, index: true
  end
end
