class Service < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 3 }

  enum status: {active: 0, inactive: 9}

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(3).upcase
  end
end
