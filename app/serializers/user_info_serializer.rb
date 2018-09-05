class UserInfoSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      events: events,
      responsibilities: [],
      expenses: expenses,
      payments: object.payments,
    }
  end

  def expenses
    object.expenses.map { |expense| {
        userName: expense.user.display_name,
        title: expense.title,
        description: expense.description,
        amount: expense.amount,
        date: expense.date,
        # payments: payments,
      }
    }
  end

  def events
    object.household.events.map { |event| {
        date: event.date,
        title: event.title,
        description: event.description,
        attendance: event.event_users,
      }
    }
  end
end
