class CoveragePricing < ApplicationRecord
  belongs_to :package_coverage
  belongs_to :package
  enum status: { active: 0, inactive: 9 }
  validates :status, presence: true
  validates :percentage_price, numericality: { in: 0..30 }
  validates_with CoverageValidator, fields: [:package_coverage]
end
