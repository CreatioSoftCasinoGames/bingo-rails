class Api::V1::PowerupsController < Api::V1::ApplicationController
	before_action :find_powerup, only: [:update, :show]
	def create
		@powerup = Powerup.new(powerup_params)
		if@powerup.save
			render json: @powerup
		else
			render json:{
				powerup: @powerup,
				errors: @powerup.errors.full_messages.join(", ")
			}
	end

	def show
		render json: @powerup
	end

	def update
		if @powerup.save(powerup_params)
			render json: @powerup
		else
			render json:{
				errors: @powerup.errors.full_messages.join(", ")
			}
	end

	private

	def powerup_params
		params.require(:powerup).permit(:free_cell, :instant_bingo, :mystry_chests, :reveal_and_daub, :double_payout, :free_coins)
	end

	def find_powerup
		@powerup = Powerup.find(params[:id])
	end
end