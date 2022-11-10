class RemoveColumnCnpjFromInsuranceCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :insurance_companies, :cnpj, :string
  end
end
