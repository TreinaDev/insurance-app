class RemoveProductCategoryFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_reference :packages, :product_category, null: false, foreign_key: true
  end
end
