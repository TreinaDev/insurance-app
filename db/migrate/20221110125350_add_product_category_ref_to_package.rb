class AddProductCategoryRefToPackage < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :product_category, null: false, foreign_key: true
  end
end
