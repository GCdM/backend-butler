class UserInfoSerializer < ActiveModel::Serializer
  attributes :data

  def data
    byebug
    {
      events: object.events,
      expenses: object.expenses,
      payments: object.payments,
    }
  end
end
