class CreatePendingPackages < ActiveRecord::Migration[7.0]
  def change
    create_table :pending_packages do |t|
      t.string :name
      t.integer :min_period
      t.integer :max_period
      t.references :insurance_company, null: false, foreign_key: true
      t.references :product_category, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
