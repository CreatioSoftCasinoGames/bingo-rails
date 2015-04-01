json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :room_id
  json.url tournament_url(tournament, format: :json)
end
