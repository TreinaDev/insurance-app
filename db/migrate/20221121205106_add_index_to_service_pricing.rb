class AddIndexToServicePricing < ActiveRecord::Migration[7.0]
  def change
    add_index :service_pricings, [:service_id, :package_id], unique: true
  end
end
