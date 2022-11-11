class Package < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category
end
