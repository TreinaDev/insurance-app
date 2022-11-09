class AddCnpjToInsuranceCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_companies, :cnpj, :string
  end
end
