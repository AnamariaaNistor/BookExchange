FactoryBot.define do
  factory :book do
    user { create(:user) }
    title { Faker::Book.title }
    author { Faker::Book.author }
    category { create(:category) }
    details { Faker::Book.publisher }
  end
end
