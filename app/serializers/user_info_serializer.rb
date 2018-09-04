class UserInfoSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      events: object.events,
      responsibilities: [],
      expenses: object.expenses,
      payments: object.payments,
    }
  end
end
