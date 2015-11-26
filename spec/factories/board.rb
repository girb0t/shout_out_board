FactoryGirl.define do
  factory :board do
    key Faker::Lorem.word
    title Faker::Lorem.sentence

    factory :active_board do
      active true
    end

    factory :inactive_board do
      active false
    end
  end
end
