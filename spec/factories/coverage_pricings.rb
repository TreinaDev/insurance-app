FactoryBot.define do
  factory :coverage_pricing do
    status { 'MyString' }
    percentage_price { '9.99' }
    coverage { nil }
    package { nil }
  end
end
