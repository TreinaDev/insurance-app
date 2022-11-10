class AddIndexTokenToInsuranceCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :insurance_companies, :token, :string
    add_index :insurance_companies, :token, unique: true
  end
end
