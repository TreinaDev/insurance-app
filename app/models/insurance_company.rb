class InsuranceCompany < ApplicationRecord
  has_many :packages, dependent: nil
  has_many :pending_packages, dependent: nil

  enum company_status: { active: 0, inactive: 1 }
  enum token_status: { token_active: 0, token_inactive: 1 }
  validates :registration_number, length: { is: 14 }
  before_validation :generate_token, on: :create
  validates :token, length: { is: 20 }
  validates :name, :email_domain, :company_status, :token_status, :registration_number, :token, presence: true
  validates :registration_number, uniqueness: true

  has_one_attached :logo

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(20).upcase
  end
end
