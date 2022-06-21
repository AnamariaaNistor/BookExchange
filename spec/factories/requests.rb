FactoryBot.define do
  factory :request do
    status { 1 }
    details { Faker::Lorem.sentence }
    exchange_requested { Exchange.all.sample }
    request_user { User.where.not(id: exchange_requested.sending_user_id).sample }
    request_book { request_user.books.sample }
  end
end
