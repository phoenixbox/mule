class RoomSerializer < ActiveModel::Serializer
  attributes :id, :contents, :created_at, :updated_at
end
