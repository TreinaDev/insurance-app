class Package < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category

  enum status: { pending: 0, active: 5, inactive: 9 }
end
