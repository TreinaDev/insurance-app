class CreateCoveragePricings < ActiveRecord::Migration[7.0]
  def change
    create_table :coverage_pricings do |t|
      t.integer :status, default: 0 
      t.decimal :percentage_price
      t.references :coverage, null: false, foreign_key: true
      t.references :package, null: false, foreign_key: true

      t.timestamps
    end
  end
end
