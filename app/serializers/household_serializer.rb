class HouseholdSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      id: object.id,
      name: object.name,
      events: object.events,
      expenses: object.expenses,
    }
  end
end
