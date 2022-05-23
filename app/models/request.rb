class Request < ApplicationRecord
  belongs_to :request_user, class_name: 'User', foreign_key: 'request_user_id'
  belongs_to :request_book, class_name: 'Book', foreign_key: 'request_book_id'
  belongs_to :exchange_requested, class_name: 'Exchange', foreign_key: 'exchange_requested_id'
end
