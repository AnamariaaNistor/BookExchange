class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :requests, foreign_key: 'request_book_id', dependent: :destroy

  has_many :sending_exchanges, class_name: 'Exchange', foreign_key: 'sended_book_id', dependent: :destroy
  has_many :sending_users, class_name: 'Exchange', foreign_key: 'sending_user_id'

  has_many :receiving_exchanges, class_name: 'Exchange', foreign_key: 'received_book_id', dependent: :destroy
  has_many :receiving_users, class_name: 'Exchange', foreign_key: 'receiving_user_id'

  has_many :donations
  has_many :sending_users, class_name: 'Donation', foreign_key: 'sending_user_id'

  has_many :donations
  has_many :receiving_users, class_name: 'Donation', foreign_key: 'receiving_user_id'

  validates :title, presence: true
  validates :author, presence: true
  validates :category_id, presence: true

  default_scope { where(deleted: false) }

  scope :available_for_request, -> { where.not(id: Request.where(status: 'waiting').pluck(:request_book_id)) }
  scope :available_for_exchange, -> { where.not(id: Exchange.where(process_status: 'waiting').pluck(:sended_book_id)) }
end
