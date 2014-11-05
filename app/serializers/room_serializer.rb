class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :active_round
end
