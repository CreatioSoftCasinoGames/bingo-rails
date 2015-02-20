class TournamentUserSerializer < ActiveModel::Serializer
  attributes :id, :daubs, :bingos, :coins, :round, :attempt_number, :full_name, :image_url
end
