FactoryBot.define do
  factory :donation do
    details { 'ceva detalii' }
    process_status { [1, 2].sample }
    sending_user { User.all.sample }
    recieving_user { User.where.not(id: sending_user.id).sample }
    sended_book { sending_user.books.sample }
  end
end
