json.array!(@scratch_card_rewards) do |scratch_card_reward|
  json.extract! scratch_card_reward, :id, :coins, :powerups, :tickets, :key, :chest
  json.url scratch_card_reward_url(scratch_card_reward, format: :json)
end
