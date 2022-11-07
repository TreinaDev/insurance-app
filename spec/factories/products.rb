FactoryBot.define do
  factory :product do
    product_model { 'MyString' }
    launch_year { 'MyString' }
    brand { 'MyString' }
    price { '9.99' }
    status { 1 }
    product_category { nil }
  end
end
