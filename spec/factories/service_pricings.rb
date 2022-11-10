FactoryBot.define do
  factory :service_pricing do
    status { 'MyString' }
    percentage_price { '9.99' }
    package { nil }
    service { nil }
  end
end
