class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_model
      t.string :launch_year
      t.string :brand
      t.decimal :price
      t.integer :status, default: 0
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
