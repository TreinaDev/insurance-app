class AddIndexToInsuranceCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_companies, :cnpj, :string
    add_index :insurance_companies, :cnpj, unique: true
  end
end
