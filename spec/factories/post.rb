FactoryGirl.define do
  factory :post do
    body Faker::Hipster.sentence
  end
end
