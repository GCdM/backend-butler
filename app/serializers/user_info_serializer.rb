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
        id: event.id,
        date: event.date,
        title: event.title,
        description: event.description,
        attendance: attendance(event.event_users),
      }
    }

    # result = events.select { |event| EventUser.find_by(event_id: event[:id], user_id: object.id).status != "rejected" }
    # result
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
    result = object.payments.map { |payment| {
        id: payment.id,
        summary: payment_summary(payment),
        userImg: payment.expense.user.img_url,
        userName: payment.expense.user.display_name,
        date: payment.updated_at,
        status: payment.status,
        expenseTitle: payment.expense.title,
        amount: payment.amount.format
      }
    }.sort_by { |payment| payment[:id] }
  end

  def attendance(event_users)
    event_users.map { |event_user| {
        id: event_user.id,
        userId: event_user.user.id,
        userImg: event_user.user.img_url,
        status: event_user.status,
      }
    }
  end

  def parse_expense_payments(payments)
    payments.map { |payment| {
        id: payment.id,
        userImg: payment.user.img_url,
        status: payment.status,
      }
    }.sort_by { |payment| payment[:id] }
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
