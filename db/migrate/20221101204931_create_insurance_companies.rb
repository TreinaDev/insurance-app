class CreateInsuranceCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :insurance_companies do |t|
      t.string :name
      t.string :email_domain
      t.string :cnpj
      t.integer :company_status, default: 0
      t.string :token
      t.integer :token_status, default: 0

      t.timestamps
    end
  end
end
