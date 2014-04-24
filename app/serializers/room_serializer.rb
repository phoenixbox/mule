class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :style,
    :beds, :tables, :chairs, :electronics,
    :accessories, :contents, :created_at, :updated_at
end
