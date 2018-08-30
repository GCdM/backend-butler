class Event < ApplicationRecord
  belongs_to :household
  has_many :event_users
end
