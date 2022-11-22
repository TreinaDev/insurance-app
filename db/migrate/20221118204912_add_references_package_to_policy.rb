class AddReferencesPackageToPolicy < ActiveRecord::Migration[7.0]
  def change
    add_reference :policies, :package, null: false, foreign_key: true
  end
end
