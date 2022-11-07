class InsuranceCompany < ApplicationRecord
  enum company_status: { active: 0, inactive: 1 }

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(20).upcase
  end
end
