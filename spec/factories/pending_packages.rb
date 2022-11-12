FactoryBot.define do
  factory :pending_package do
    name { 'MyString' }
    min_period { 1 }
    max_period { 1 }
    insurance_company { nil }
    product_category { nil }
    status { 1 }
  end
end
