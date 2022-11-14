class RemoveMaxPeriodFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_column :packages, :max_period, :string
  end
end
