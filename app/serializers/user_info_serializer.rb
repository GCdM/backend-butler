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
        payments: parse_expense_payments(expense.payments),
      }
    }
  end

  def payments
    object.payments.map { |payment| {
        summary: payment_summary(payment),
        userImg: payment.expense.user.img_url,
        userName: payment.expense.user.display_name,
        date: payment.updated_at,
        status: payment.status,
        expenseTitle: payment.expense.title,
        amount: payment.amount.format
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
        userImg: payment.user.img_url,
        status: payment.status,
      }
    }
  end

  def payment_summary(payment)
    if payment.status === "settled"
      "You've paid "
    elsif payment.status === "pending"
      "Awaiting confirmation that you've paid "
    else
      "You owe "
    end
  end
end
