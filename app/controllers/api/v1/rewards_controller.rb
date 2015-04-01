class Api::V1::RewardsController < Api::V1::ApplicationController

	def mark_as_collected
		@reward = Reward.where(id: params[:id], is_collected: false).first
		if @reward.update_attributes(is_collected: true, user_attributes: {id: @reward.user.id, reward_coins: params[:coins], reward_tickets: params[:tickets]})
			render json: {
				success: true
			}
		else
			render json: {
				success: false
			}
		end
	end

end