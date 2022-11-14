class RemoveMinPeriodFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_column :packages, :min_period, :string
  end
end
