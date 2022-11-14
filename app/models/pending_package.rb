class PendingPackage < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category
  has_one :package, dependent: nil

  validates :name, :min_period, :max_period, presence: true
  validates :min_period, numericality: { greater_than: 0 }
  validates :min_period, comparison: { less_than_or_equal_to: :max_period }

  enum status: { pending: 0, active: 9, inactive: 17 }
end
