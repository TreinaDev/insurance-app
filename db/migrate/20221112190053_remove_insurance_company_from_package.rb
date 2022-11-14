class RemoveInsuranceCompanyFromPackage < ActiveRecord::Migration[7.0]
  def change
    remove_reference :packages, :insurance_company, null: false, foreign_key: true
  end
end
