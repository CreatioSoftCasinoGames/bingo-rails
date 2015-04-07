class UtilityController < ApplicationController
	def show_api_key
		@api_key = ApiKey.where(active: true).first
	end

	def generate_api_key 
		ApiKey.create
		redirect_to show_api_key_url, flash: {success: "New keys created successfully !"}
	end

	def sync_data
		RoomConfig.includes(:rooms).all.each do |room_config|
			if (room_config.room_type=="Normal")
				REDIS_CLIENT.SADD("normal_room_players", "onlinePlayer:#{room_config.id}")
			elsif (room_config.room_type=="Special")
					REDIS_CLIENT.SADD("special_room_players", "onlinePlayer:#{room_config.id}")
			else
				REDIS_CLIENT.SADD("tournament_room_players", "onlinePlayer:#{room_config.id}")				
			end
			
			REDIS_CLIENT.SADD("room_configs", "room_config:#{room_config.id}")
			REDIS_CLIENT.HMSET("room_config:#{room_config.id}", "name", room_config.name, "min_players", room_config.min_players, "max_players", room_config.max_players, "room_type", room_config.room_type);
			room_config.rooms.each do |room|
				REDIS_CLIENT.SADD("rooms","room:#{room.id}")
				REDIS_CLIENT.SADD("room_config_rooms:#{room.room_config_id}", "room:#{room.id}")
				REDIS_CLIENT.ZADD("room_config_occupancy:#{room.room_config_id}", 0, "room:#{room.id}")
				REDIS_CLIENT.HMSET("room:#{room.id}", "name", room.name, "room_config_id", room.room_config_id, "bingo_factor", room_config.num_bingo_factor, "divider", room_config.divider)
			end
		end
		TicketProbability.get_tickets.each do |room_id, probability|
		  REDIS_CLIENT.SADD("ticket_probabilities", "room_id:#{room_id}")
			REDIS_CLIENT.set("room_id:#{room_id}", probability)
		end	
		BotsProbability.get_bots.each do |max_players, probabilities|
			REDIS_CLIENT.ZADD("bots_probabilities_sorted_set", max_players, "bots_probability_players:#{max_players}")
			REDIS_CLIENT.set("bots_probability_players:#{max_players}", probabilities)
		end
		BotBingoNumber.all.each do |bot_bingo|
			REDIS_CLIENT.SADD("bot_bingos", "bot_bingo:#{bot_bingo.number_of_bots}")
			REDIS_CLIENT.SET("bot_bingo:#{bot_bingo.number_of_bots}", bot_bingo.starting_number)
		end
		User.where(is_bot: true).each do |bot_player|
			REDIS_CLIENT.SADD("bot_available", bot_player.login_token)
		end
		REDIS_CLIENT.DEL("bot_busy")
		redirect_to root_path, flash: {success: "Data successfully synced !" }
	end
end

