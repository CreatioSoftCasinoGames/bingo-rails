class LevelProgrationSerializer < ActiveModel::Serializer
  attributes :id, :level, :xp, :xp_difference, :xp_per_daub, :coins_per_bingo, :tickets_per_bingo, :card_cost
end
