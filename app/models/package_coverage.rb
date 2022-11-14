class PackageCoverage < ApplicationRecord
  has_many :coverage_pricings, dependent: nil

  validates :name, :description, presence: true
  validates :description, length: { minimum: 3 }
  validates :name, uniqueness: true
end
