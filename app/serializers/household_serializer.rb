class HouseholdSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      id: object.id,
      name: object.name,
      events: events,
      responsibilities: [],
      expenses: expenses,
    }
  end

  def events
    object.events.map { |event| {
        id: event.id,
        date: event.date,
        title: event.title,
        description: event.description,
        attendance: attendance(event.event_users),
      }
    }
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

  def parse_expense_payments(payments)
    payments.map { |payment| {
        id: payment.id,
        userImg: payment.user.img_url,
        status: payment.status,
      }
    }.sort_by { |payment| payment[:id] }
  end
end
