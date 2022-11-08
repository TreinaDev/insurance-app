class AddIndexToInsuranceCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_companies, :registration_number, :string
    add_index :insurance_companies, :registration_number, unique: true
  end
end
