class CoveragePricing < ApplicationRecord
  belongs_to :coverage
  belongs_to :package
  enum status: { active: 0, inactive: 9 }
end
