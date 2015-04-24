class Api::V1::RoomConfigsController < Api::V1::ApplicationController

	before_action :find_room_config, only: [:leader_board]
	
	def index
		@room_configs = RoomConfig.where(true)
		(@room_configs = @room_configs.where(room_type: params[:room_type])) if params[:room_type]
		render json: @room_configs
	end

	def active_tournament
		tournaments.where(active: true).last
	end

	def get_room_type
		@room_configs = RoomConfig.where(room_type: params[:room_type])
		room_obj = @room_configs.collect(&:rooms).flatten.uniq.collect do |room|
			{
				id: room.id,
				name: room.name,
				min_player: room.room_config.min_player,
				max_player: room.room_config.max_player,
				game_type: room.room_config.room_type
			}
		end
		render json: room_obj
	end

	def my_rank(user_id)
		self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_f + 1
	end

	def leader_board
		@user = User.fetch_by_login_token(params[:login_token])
		tournament_type = @room_config.active_tournament.tournament_type
		if tournament_type == "Daily_Free"
			users_score = @room_config.active_tournament.tournament_users.order("score desc")
		elsif tournament_type == "Weekly"
			users_score = @room_config.find_tournament(@room_config.id, @user.id).tournament_users.order("score desc")
		elsif tournament_type == "Monthly"
			users_score = @room_config.find_tournament(@room_config.id, @user.id).tournament_users.order("score desc")
		end
		leader_board = users_score.limit(20).as_json({
			only: [:score],
			methods: [:full_name, :image_url]
		}).each_with_index.map do |player_obj, i|
			player_obj[:rank] = i + 1
			player_obj
		end
		render json: {
			leader_board: leader_board,
			my_rank: @room_config.my_rank(@user.id)
		}
	end

	private

	def find_room_config
		@room_config = RoomConfig.where(id: params[:id]).first
		(render json: {message: "Room config not found", success: false}) if @room_config.blank?
	end

end