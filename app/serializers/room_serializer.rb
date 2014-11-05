class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :min_stake, :max_stake, :min_buy_in, :max_buy_in, :max_players
end
