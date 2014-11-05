json.array!(@rounds) do |round|
  json.extract! round, :id, :room_id, :num_players, :deck, :num_cards
  json.url round_url(round, format: :json)
end
