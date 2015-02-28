json.array!(@tournament_users) do |tournament_user|
  json.extract! tournament_user, :id, :tournament_id, :user_id, :round, :daubs, :bingos, :coins, :attempt_number
  json.url tournament_user_url(tournament_user, format: :json)
end
