class Payment < ApplicationRecord
  belongs_to :expense
  belongs_to :user
end
