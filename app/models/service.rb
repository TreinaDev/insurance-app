class Service < ApplicationRecord
  validates :name, :description, :status, :code, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 3 }
  validates :code, uniqueness: true

  enum status: { active: 0, inactive: 9 }

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(3).upcase
  end
end
