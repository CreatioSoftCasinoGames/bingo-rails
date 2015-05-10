class BingoPointSerializer < ActiveModel::Serializer
  attributes :id, :xp, :cell_coin, :ticket_cost, :theme_level
end
