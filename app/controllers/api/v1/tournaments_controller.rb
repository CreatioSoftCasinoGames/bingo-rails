class Api::V1::TournamentsController < Api::V1::ApplicationController

	def leader_board
		@leader_board = TournamentUser.where(room_id: params[:room_id]).all
		render json: @leader_board
	end

	def show
		@leader_board = TournamentUser.where(room_id: params[:room_id]).all
		render json: @leader_board
	end

end