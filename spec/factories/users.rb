FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { ENV['GLOBAL_PASS'] }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    city { Faker::Address.city }
    county { Faker::Address.city }

    trait :with_books do
      transient do
        count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:book, evaluator.count, user: user)
      end
    end
  end
end
