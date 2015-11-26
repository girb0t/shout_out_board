FactoryGirl.define do
  factory :category do
    title Faker::Lorem.sentence
    prompt Faker::Lorem.sentence
  end
end
