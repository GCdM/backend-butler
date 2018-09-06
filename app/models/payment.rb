class Payment < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  monetize :amount_cents, as: "amount"

  def status
    if self.received
      "settled"
    elsif self.paid
      "pending"
    else
      "unpaid"
    end
  end
end
