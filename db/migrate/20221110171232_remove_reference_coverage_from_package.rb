class RemoveReferenceCoverageFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_reference :packages, :coverage_pricing, foreign_key: true
  end
end
