class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :rooms

  def rooms
    [
      {id: 1},
      {id: 2}
    ]
  end
end
