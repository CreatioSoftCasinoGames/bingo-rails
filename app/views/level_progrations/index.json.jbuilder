json.array!(@level_progrations) do |level_progration|
  json.extract! level_progration, :id, :level, :xp, :xp_difference, :xp_per_daub, :coins_per_bingo, :tickets_per_bingo, :card_cost
  json.url level_progration_url(level_progration, format: :json)
end
