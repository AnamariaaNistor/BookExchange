class Donation < ApplicationRecord
  belongs_to :sending_user, class_name: 'User', foreign_key: 'sending_user_id'
  belongs_to :recieving_user, class_name: 'User', foreign_key: 'recieving_user_id', optional: true

  belongs_to :sended_book, class_name: 'Book', foreign_key: 'sended_book_id'

  enum sending_status: { 'waiting' => 0, 'in progress' => 1, 'done' => 2 }, _prefix: :sending
  enum recieving_status: { 'waiting' => 0, 'in progress' => 1, 'done' => 2 }, _prefix: :recieving
  enum process_status: { 'waiting' => 0, 'in progress' => 1, 'done' => 2 }
end
