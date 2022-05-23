FactoryBot.define do
  factory :donation do
    details { "ceva detalii" }
    sending_status { 1 }
    recieving_status { 1 }
    process_status { 1 }
    sending_user { User.all.sample }
    recieving_user { User.all.sample }
    sended_book { sending_user.books.sample }
  end
end
