FactoryBot.define do
  factory :package do
    name { 'MyString' }
    max_period { 1 }
    min_period { 1 }
    insurance_company { nil }
    price { '9.99' }
  end
end
