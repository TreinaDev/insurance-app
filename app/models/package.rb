class Package < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category
  has_many :coverage_pricings, dependent: nil
  has_many :service_pricings, dependent: nil

  validates :name, :min_period, :max_period, presence: true
  validates :min_period, numericality: { greater_than: 0 }
  validates :min_period, comparison: { less_than_or_equal_to: :max_period }

  enum status: { pending: 0, active: 5, inactive: 9 }
end
