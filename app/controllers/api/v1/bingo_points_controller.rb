class Api::V1::BingoPointsController < Api::V1::ApplicationController

	def index
		render json: BingoPoint.all
	end

end