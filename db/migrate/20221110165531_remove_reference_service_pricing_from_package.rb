class RemoveReferenceServicePricingFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_reference :packages, :service_pricing, foreign_key: true
  end
end
