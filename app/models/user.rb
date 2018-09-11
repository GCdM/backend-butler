class User < ApplicationRecord
  has_secure_password
  belongs_to :household, optional: true
  has_many :expenses
  has_many :payments
  has_many :event_users
  has_many :events, through: :event_users
  has_many :responsibility_users

  validates :username, uniqueness: true
end
