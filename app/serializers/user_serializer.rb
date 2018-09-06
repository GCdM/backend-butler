class UserSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      id: object.id,
      username: object.username,
      displayName: object.display_name,
      householdId: object.household_id,
      imgUrl: object.img_url,
    }
  end
end
