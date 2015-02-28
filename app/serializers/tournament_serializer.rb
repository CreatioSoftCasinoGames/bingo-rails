class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :room_id
  has_many :tournament_users
end
