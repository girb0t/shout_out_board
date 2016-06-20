FactoryGirl.define do
  factory :category do
    title Faker::Lorem.sentence
    prompt Faker::Lorem.sentence
    tab_name Faker::Lorem.word
  end
end
