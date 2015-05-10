class Api::V1::ScratchCardRewardsController < Api::V1::ApplicationController

	def index
		render json: ScratchCardReward.all
	end

end