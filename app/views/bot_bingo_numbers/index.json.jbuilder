json.array!(@bot_bingo_numbers) do |bot_bingo_number|
  json.extract! bot_bingo_number, :id, :number_of_bots, :starting_number
  json.url bot_bingo_number_url(bot_bingo_number, format: :json)
end
