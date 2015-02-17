class Api::V1::RoomsController < Api::V1::ApplicationController

	before_action :find_room, only: [:show, :get_bingo_factor]

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

	def show
		render json: @room
	end

	private

	def find_room
		@room = Room.where(id: params[:id]).first
		(render json: {message: "Room not found", success: false}) if @room.blank?
	end

end