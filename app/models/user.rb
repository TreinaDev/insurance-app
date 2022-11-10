class User < ApplicationRecord
  enum :role, { employee: 10, admin: 20 }, default: :employee

  before_validation :add_insurance_company, on: :create
  belongs_to :insurance_company, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  private

  def add_insurance_company
    self.insurance_company = InsuranceCompany.find_by(email_domain: email.partition('@').last) if admin? == false
  end
end
