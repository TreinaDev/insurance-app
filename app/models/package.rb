class Package < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category

  validates :name, :min_period, :max_period, presence: true

  enum status: { pending: 0, active: 5, inactive: 9 }
end
