class CoveragePricing < ApplicationRecord
  belongs_to :coverage
  belongs_to :package
end
