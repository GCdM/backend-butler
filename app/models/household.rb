class Household < ApplicationRecord
  has_many :users
  has_many :events
  has_many :expenses, through: :users
end
