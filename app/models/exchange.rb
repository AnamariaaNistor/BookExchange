class Exchange < ApplicationRecord
  belongs_to :sending_user, class_name: 'User', foreign_key: 'sending_user_id'
  belongs_to :recieving_user, class_name: 'User', foreign_key: 'recieving_user_id', optional: true

  belongs_to :sended_book, class_name: 'Book', foreign_key: 'sended_book_id'
  belongs_to :recieved_book, class_name: 'Book', foreign_key: 'recieved_book_id', required: false

  has_many :requests, foreign_key: 'exchange_requested_id'

  enum process_status: { 'waiting' => 0, 'in progress' => 1, 'done' => 2 }
  enum type_of_exchange: { 'temporary' => 0, 'permanent' => 1 }

  validates :sending_user_id, presence: true
  validates :sended_book_id, presence: true
  validates :details, presence: true

  default_scope { where(deleted: false) }

  scope :availible, -> { where(process_status: 0) }
end
