require 'faker'

class User < ApplicationRecord
  has_secure_password
  belongs_to :household, optional: true
  has_many :expenses
  has_many :payments
  has_many :event_users
  has_many :events, through: :event_users
  has_many :responsibility_users
  has_many :responsibilities, through: :responsibility_users

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

  def initialize(args)
    super(args)
    self.update(img_url: Faker::Avatar.image)
  end
end
