class AddServiceAndCoverageToPackage < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :service_pricing, null: false, foreign_key: true
    add_reference :packages, :coverage_pricing, null: false, foreign_key: true
  end
end
