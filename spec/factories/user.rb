FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    username Faker::Internet.user_name
    password Faker::Internet.password

    factory :user_with_boards do
      transient do
        boards_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:board, evaluator.boards_count, user: user)
      end
    end
  end
end
