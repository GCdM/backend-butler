class HouseholdSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      id: object.id,
      name: object.name,
      members: members,
      events: events,
      responsibilities: responsibilities,
      expenses: expenses,
    }
  end

  def members
    object.users.map { |user|
      {
        id: user.id,
        displayName: user.display_name,
        imgUrl: user.img_url,
      }
    }
  end

  def events
    object.events.map { |event|
      {
        id: event.id,
        date: event.date,
        title: event.title,
        description: event.description,
        attendance: attendance(event.event_users),
      }
    }
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
    logs.map { |log|
      {
        userImg: log.user.img_url,
        date: log.date,
        responsibilityTitle: log.responsibility.title,
        description: log.description,
      }
    }.sort_by { |log| log[:date] }.reverse
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
    }.sort_by { |expense| expense[:date] }.reverse
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
end
