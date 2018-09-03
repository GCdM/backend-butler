class Expense < ApplicationRecord
  belongs_to :user
  has_one :household, through: :user
  has_many :payments

  def initialize(args)
    super(args)
    self.save
    self.generate_payments
  end

  def generate_payments
    divider = self.household.users.count
    payment_amount = (self.amount / divider)
    self.household.users.each do |user|
      if user != self.user
        Payment.create(user_id: user.id, expense_id: self.id, amount: payment_amount, paid: false, received: false)
      end
    end
  end
end
