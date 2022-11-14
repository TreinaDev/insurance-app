class RemoveNameFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_column :packages, :name, :string
  end
end
