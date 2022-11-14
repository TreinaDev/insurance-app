class AddPendingPackageToCoveragePricing < ActiveRecord::Migration[7.0]
  def change
    add_reference :coverage_pricings, :pending_package, null: false, foreign_key: true
  end
end
