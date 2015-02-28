json.array!(@tournament_rewards) do |tournament_reward|
  json.extract! tournament_reward, :id, :reward_type
  json.url tournament_reward_url(tournament_reward, format: :json)
end
