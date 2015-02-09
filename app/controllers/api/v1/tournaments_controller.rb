class Api::V1::TournamentsController < Api::V1:ApplicationController

	def leader_board
		@tournament = Tournament.where(id: params[:id]).first
		@leader_board = @tournament.users.all
		render json: @leader_board
	end

end