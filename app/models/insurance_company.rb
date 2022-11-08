class InsuranceCompany < ApplicationRecord
  enum company_status: { active: 0, inactive: 1 }
  validates :cnpj, length: { is: 14 }
  validates :cnpj, uniqueness: true

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(20).upcase
  end
end




def change
  add_index :orders, :order_number, unique: true
end