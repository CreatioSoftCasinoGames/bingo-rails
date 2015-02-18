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
		leader_board = @room.active_tournament.tournament_users.order("score desc").limit(20).as_json({
			only: [:score],
			methods: [:full_name, :image_url]
		}).each_with_index.map do |player_obj, i|
			player_obj[:rank] = i + 1
			player_obj
		end
		render json: {
			leader_board: leader_board,
			my_rank: @room.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(@user.id).to_f + 1
		}
	end

	def show
		render json: @room
	end

	private

	def find_room
		@room = Room.where(id: params[:id]).first
	end

end