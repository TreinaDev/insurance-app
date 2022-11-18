class PackageCoverage < ApplicationRecord
  has_many :coverage_pricings, dependent: nil

  validates :name, :description, :status, :code, presence: true
  validates :description, length: { minimum: 3 }
  validates :name, uniqueness: true
  validates :code, uniqueness: true

  enum status: { active: 0, inactive: 9 }

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(3).upcase
  end
end
