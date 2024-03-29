FactoryBot.define do
  factory :exchange do
    details { 'ceva detalii' }
    process_status { [1, 2].sample }
    type_of_exchange { 1 }
    sending_user { User.all.sample }
    receiving_user { User.where.not(id: sending_user.id).sample }
    sended_book { sending_user.books.sample }
    received_book { receiving_user&.books&.sample }
  end
end
