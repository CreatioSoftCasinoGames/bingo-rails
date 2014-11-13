class Api::V1::RoomsController < Api::V1::ApplicationController

	def index
		render json: Room.all
	end

	def show
		@room = Room.where(id: params[:id]).first
		render json: @room
	end

end