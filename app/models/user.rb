class User < ApplicationRecord
  enum :role, { employee: 10, admin: 20 }, default: :employee

  belongs_to :insurance_company

  before_validation :add_insurance_company, on: :create
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  private

  def add_insurance_company
    self.insurance_company = InsuranceCompany.find_by(email_domain: self.email.partition('@').last)
  end
end
