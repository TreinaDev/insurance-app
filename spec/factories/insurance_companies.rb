FactoryBot.define do
  factory :insurance_company do
    name { 'MyString' }
    email_domain { 'MyString' }
    company_status { 1 }
    token { 'MyString' }
    token_status { 1 }
  end
end
