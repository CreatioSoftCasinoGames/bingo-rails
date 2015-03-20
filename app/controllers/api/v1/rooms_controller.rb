class Api::V1::RoomsController < Api::V1::ApplicationController

	before_action :find_room, only: [:show, :get_bingo_factor, :leader_board]

	def index
		render json: Room.all
	end

	def get_bingo_factor
		render json: {
			bingo_factor: @room.as_json({
				only: [:num_bingo_factor, :divider]
			})
		}
	end

	def leader_board
		@user = User.fetch_by_login_token(params[:login_token])
		tournament_type = @room.active_tournament.tournament_type
		if tournament_type == "daily"
			users_score = @room.active_tournament.tournament_users.order("score desc")
		elsif tournament_type == "weekly"
			users_score = @room.find_tournament(@room.id, @user.id).tournament_users.order("score desc")
		elsif tournament_type == "monthly"
			users_score = @room.find_tournament(@room.id, @user.id).tournament_users.order("score desc")
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
			my_rank: @room.my_rank(@user.id)
		}
	end

	def show
		render json: @room
	end

	private

	def find_room
		@room = Room.where(id: params[:id]).first
		(render json: {message: "Room not found", success: false}) if @room.blank?
	end

end