class RoomConfigSerializer < ActiveModel::Serializer
  attributes :id, :name, :room_type, :min_players, :max_players, :timeout, :num_bingo_factor, :divider
end
