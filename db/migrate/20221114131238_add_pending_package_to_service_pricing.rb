class AddPendingPackageToServicePricing < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_pricings, :pending_package, null: false, foreign_key: true
  end
end
