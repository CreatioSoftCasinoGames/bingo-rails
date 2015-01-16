class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :room_type, :timeout
end
