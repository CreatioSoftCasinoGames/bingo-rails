json.array!(@bingo_points) do |bingo_point|
  json.extract! bingo_point, :id, :xp, :cell_coin, :ticket_cost, :theme_level
  json.url bingo_point_url(bingo_point, format: :json)
end
