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
			REDIS_CLIENT.SADD("room_configs", "room_config:#{room_config.id}")
			REDIS_CLIENT.HMSET("room_config:#{room_config.id}", "name", room_config.name, "min_players", room_config.min_players, "max_players", room_config.max_players, "room_type", room_config.room_type);
			room_config.rooms.each do |room|
				REDIS_CLIENT.SADD("rooms","room:#{room.id}")
				REDIS_CLIENT.SADD("room_config_rooms:#{room.room_config_id}", "room:#{room.id}")
				REDIS_CLIENT.ZADD("room_config_occupancy:#{room.room_config_id}", 0, "room:#{room.id}")
				REDIS_CLIENT.HMSET("room:#{room.id}", "name", room.name, "room_config_id", room.room_config_id)
			end
		end
		redirect_to root_path, flash: {success: "Data successfully synced !" }
	end

end