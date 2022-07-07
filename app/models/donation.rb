class Donation < ApplicationRecord
  belongs_to :sending_user, class_name: 'User', foreign_key: 'sending_user_id'
  belongs_to :receiving_user, class_name: 'User', foreign_key: 'receiving_user_id', optional: true

  belongs_to :sended_book, class_name: 'Book', foreign_key: 'sended_book_id', dependent: :destroy

  enum process_status: { 'waiting' => 0, 'in progress' => 1, 'done' => 2 }

  scope :available, -> { where(process_status: 0) }
  default_scope { where(deleted: false) }
end
