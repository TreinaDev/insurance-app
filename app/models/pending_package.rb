class PendingPackage < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category

  validates :name, :min_period, :max_period, presence: true
  validates :min_period, numericality: { greater_than: 0 }
  validates :min_period, comparison: { less_than: :max_period }

  enum status: { pending: 0, active: 9 }
end
