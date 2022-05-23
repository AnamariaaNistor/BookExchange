# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REQUIREMENTS = /\A(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}\z/.freeze

  has_many :books

  has_many :exchanges
  has_many :sended_books, class_name: 'Exchange', foreign_key: 'sended_book_id'

  has_many :exchanges
  has_many :recieved_books, class_name: 'Exchange', foreign_key: 'recieved_book_id'

  has_many :donations
  has_many :sended_books, class_name: 'Donation', foreign_key: 'sended_book_id'

  scope :not_deleted, -> { where(deleted: false) }
end
