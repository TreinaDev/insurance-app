FactoryBot.define do
  factory :policy do
    code { 'MyString' }
    expiration_date { '2022-11-01' }
    status { 1 }
  end
end
