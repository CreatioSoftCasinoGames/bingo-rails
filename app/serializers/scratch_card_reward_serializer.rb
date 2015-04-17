class ScratchCardRewardSerializer < ActiveModel::Serializer
  attributes :id, :coins, :powerups, :tickets, :key, :chest
end
