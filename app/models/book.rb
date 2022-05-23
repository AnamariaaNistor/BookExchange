class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :exchanges
  has_many :sending_users, class_name: 'Exchange', foreign_key: 'sending_user_id'

  has_many :exchanges
  has_many :recieving_users, class_name: 'Exchange', foreign_key: 'recieving_user_id'

  has_many :donations
  has_many :sending_users, class_name: 'Donation', foreign_key: 'sending_user_id'

  has_many :donations
  has_many :recieving_users, class_name: 'Donation', foreign_key: 'recieving_user_id'

  validates :title, presence: true
  validates :author, presence: true
  validates :category_id, presence: true

  scope :not_deleted, -> { where(deleted: false) }
end
