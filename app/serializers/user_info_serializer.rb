class UserInfoSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      events: events,
      responsibilities: [],
      expenses: expenses,
      payments: payments,
    }
  end

  def events
    object.household.events.map { |event| {
        date: event.date,
        title: event.title,
        description: event.description,
        # attendance: attendance(event.event_users),
      }
    }
  end

  def expenses
    object.expenses.map { |expense| {
        userName: expense.user.display_name,
        userImg: expense.user.img_url,
        title: expense.title,
        description: expense.description,
        amount: expense.amount.format,
        date: expense.date,
        # payments: parse_expense_payments(expense.payments),
      }
    }
  end

  def payments
    object.payments.map { |payment| {
        summary: payment_summary(payment),
        userImg: payment.expense.user.img_url,
        date: payment.updated_at,
      }
    }
  end

  def attendance(event_users)
    event_users.map { |event_user| {

      }
    }
  end

  def parse_expense_payments(payments)
    payments.map { |payment| {

      }
    }
  end

  def payment_summary(payment)
    if payment.received
      "You've paid #{payment.amount.format} to #{payment.expense.user.display_name} for #{payment.expense.title}"
    elsif payment.paid
      "Awaiting confirmation that you've paid #{payment.amount.format} to #{payment.expense.user.display_name} for #{payment.expense.title}"
    else
      "You owe #{payment.amount.format} to #{payment.expense.user.display_name} for #{payment.expense.title}"
    end
  end
end
