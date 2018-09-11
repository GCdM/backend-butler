class ResponsibilityUser < ApplicationRecord
  belongs_to :responsibility
  belongs_to :user
end
