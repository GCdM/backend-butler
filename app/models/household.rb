class Household < ApplicationRecord
  has_many :users
  has_many :events
  has_many :expenses, through: :users
  has_many :responsibilities

  validates :key, uniqueness: true
end
