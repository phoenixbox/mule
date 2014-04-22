class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :rooms

  has_many :rooms
end
