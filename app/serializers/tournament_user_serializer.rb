class TournamentUserSerializer < ActiveModel::Serializer
  attributes :id, :tournament_id, :user_id, :round, :daubs, :bingos, :coins, :attempt_number
end
