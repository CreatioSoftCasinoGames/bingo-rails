json.array!(@room_configs) do |room_config|
  json.extract! room_config, :id, :name, :type, :min_players, :max_players, :timeout, :num_bingo_factor, :divider
  json.url room_config_url(room_config, format: :json)
end
