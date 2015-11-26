FactoryGirl.define do
  factory :post do
    body Faker::Lorem.sentence
  end
end
