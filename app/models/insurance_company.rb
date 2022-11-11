class InsuranceCompany < ApplicationRecord
  enum company_status: { active: 0, inactive: 1 }
  validates :registration_number, length: { is: 14 }
  before_validation :generate_token, on: :create
  validates :token, length: { is: 20 }

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(20).upcase
  end
end