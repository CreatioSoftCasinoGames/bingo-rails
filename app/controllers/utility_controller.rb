class UtilityController < ApplicationController

	def show_api_key
		@api_key = ApiKey.where(active: true).first
	end

	def generate_api_key 
		ApiKey.create
		redirect_to show_api_key_url, flash: {success: "New keys created successfully !"}
	end

	def sync_data
		Room.all.each do |room|
			REDIS_CLIENT.SADD("rooms", "room:#{room.id}")
			REDIS_CLIENT.HMSET("room:#{room.id}", "name", room.name, "room_type", room.room_type, "timeout", room.timeout, "factor", room.num_bingo_factor, "divider", room.divider)
		end
		redirect_to root_path, flash: {success: "Data successfully synced !" }
	end

end