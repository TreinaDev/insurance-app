class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :max_period
      t.integer :min_period
      t.references :insurance_company, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
