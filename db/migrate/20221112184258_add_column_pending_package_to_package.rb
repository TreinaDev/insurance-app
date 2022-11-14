class AddColumnPendingPackageToPackage < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :pending_package, null: false, foreign_key: true
  end
end
