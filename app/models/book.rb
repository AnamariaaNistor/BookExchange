class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :requests, foreign_key: 'request_book_id'

  has_many :sending_exchanges, class_name: 'Exchange', foreign_key: 'sended_book_id'
  has_many :sending_users, class_name: 'Exchange', foreign_key: 'sending_user_id'

  has_many :recieving_exchanges, class_name: 'Exchange', foreign_key: 'recieved_book_id'
  has_many :recieving_users, class_name: 'Exchange', foreign_key: 'recieving_user_id'

  has_many :donations
  has_many :sending_users, class_name: 'Donation', foreign_key: 'sending_user_id'

  has_many :donations
  has_many :recieving_users, class_name: 'Donation', foreign_key: 'recieving_user_id'

  validates :title, presence: true
  validates :author, presence: true
  validates :category_id, presence: true

  scope :not_deleted, -> { where(deleted: false) }

  scope :availible_for_exchange, -> { where.not(id: Request.where(status: 'waiting').pluck(:request_book_id)) }
end
