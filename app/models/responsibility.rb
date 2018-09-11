class Responsibility < ApplicationRecord
  belongs_to :household
  has_many :responsibility_users
  has_many :users, through: :responsibility_users
end
