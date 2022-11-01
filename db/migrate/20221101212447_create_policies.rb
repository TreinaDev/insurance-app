class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.string :code
      t.date :expiration_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
