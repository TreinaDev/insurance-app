class AddReferencesToPolicy < ActiveRecord::Migration[7.0]
  def change
    add_reference :policies, :insurance_company, null: false, foreign_key: true
  end
end
