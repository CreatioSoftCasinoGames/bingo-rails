class Api::V1::LevelProgrationsController < Api::V1::ApplicationController

	def index
		render json: LevelProgration.all
	end

end