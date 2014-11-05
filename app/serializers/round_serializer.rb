class RoundSerializer < ActiveModel::Serializer
  attributes :id, :room_id, :num_players, :deck, :num_cards
end
