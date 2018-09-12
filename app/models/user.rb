class User < ApplicationRecord
  has_secure_password
  belongs_to :household, optional: true
  has_many :expenses
  has_many :payments
  has_many :event_users
  has_many :events, through: :event_users
  has_many :responsibility_users
  has_many :responsibilities, through: :responsibility_users

  validates :username, uniqueness: true

  def initialize(args)
    super(args)

    if !args[:img_url]
      self.update(img_url: "https://robohash.org/oditutad.png?size=300x300&set=set1")
    end
  end
end
