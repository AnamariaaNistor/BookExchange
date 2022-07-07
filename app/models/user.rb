# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REQUIREMENTS = /\A(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}\z/.freeze

  has_many :books

  has_many :requests, foreign_key: 'request_user_id'
  # has_many :request_books, class_name: 'Request', foreign_key: 'request_book_id'

  has_many :sending_exchanges, class_name: 'Exchange', foreign_key: 'sending_user_id'
  has_many :receiving_exchanges, class_name: 'Exchange', foreign_key: 'receiving_user_id'

  has_many :sended_books, class_name: 'Exchange', foreign_key: 'sended_book_id', dependent: :destroy
  has_many :received_books, class_name: 'Exchange', foreign_key: 'received_book_id'

  has_many :sending_donaions, class_name: 'Donation', foreign_key: 'sending_user_id'
  has_many :receiving_donations, class_name: 'Donation', foreign_key: 'receiving_user_id'
  has_many :sended_books, class_name: 'Donation', foreign_key: 'sended_book_id', dependent: :destroy

  default_scope { where(deleted: false) }
end
