class Event < ApplicationRecord
  belongs_to :household
  has_many :event_users

  def initialize(args)
    super(args)
    self.save
    self.generate_invites
  end

  def generate_invites
    self.household.users.each do |user|
      EventUser.create(event: self, user: user, status: "pending")
    end
  end
end
