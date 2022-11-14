class AddStatusToPackage < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :status, :integer, default: 9
  end
end
