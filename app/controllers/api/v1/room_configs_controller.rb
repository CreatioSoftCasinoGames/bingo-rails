class Api::V1::RoomConfigsController < Api::V1::ApplicationController

	def index
		@room_configs = RoomConfig.where(true)
		(@room_configs = @room_configs.where(type: params[:room_type])) if params[:room_type]
		render json: @room_configs
	end

	def get_room_type
		@room_configs = RoomConfig.where(type: params[:room_type])
		room_obj = @room_configs.collect(&:rooms).flatten.uniq.collect do |room|
			{
				id: room.id,
				name: room.name,
				min_player: room.room_config.min_player,
				max_player: room.room_config.max_player,
				game_type: room.room_config.type
			}
		end
		render json: room_obj
	end

end