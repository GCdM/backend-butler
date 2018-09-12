class UserInfoSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      id: object.id,
      displayName: object.display_name,
      imgUrl: object.img_url,
      events: events,
      responsibilities: responsibilities,
      expenses: expenses,
      payments: payments,
    }
  end

  def events
    object.household.events.map { |event|
      {
        id: event.id,
        date: event.date,
        title: event.title,
        description: event.description,
        attendance: attendance(event.event_users),
      }
    }.sort_by { |event| event[:date] }
  end

  def expenses
    object.expenses.map { |expense|
      {
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

  def responsibilities
    object.responsibilities.map { |responsibility|
      {
        id: responsibility.id,
        title: responsibility.title,
        logs: parse_logs(responsibility.responsibility_users),
      }
    }
  end

  def parse_logs(logs)
    logs.select { |log|
      log.user.id === object.id
    }.map { |log|
      {
        userImg: log.user.img_url,
        date: log.date,
        responsibilityTitle: log.responsibility.title,
        description: log.description,
      }
    }.sort_by { |log| log[:date] }.reverse
  end

  def payments
    result = object.payments.map { |payment|
      {
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
    event_users.map { |event_user|
      {
        id: event_user.id,
        userId: event_user.user.id,
        userImg: event_user.user.img_url,
        status: event_user.status,
      }
    }.sort_by { |attendance| attendance[:id] }
  end

  def parse_expense_payments(payments)
    payments.map { |payment|
      {
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
