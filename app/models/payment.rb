class Payment < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  monetize :amount_cents, as: "amount"
end
