class ExpenseSerializer < ActiveModel::Serializer
  attributes :data

  def data
    {
      userName: object.user.display_name,
      userImg: object.user.img_url,
      title: object.title,
      description: object.description,
      amount: object.amount,
      date: object.date,
      # payments: payments,
    }
  end
end
