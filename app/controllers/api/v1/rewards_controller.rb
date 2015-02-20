class Api::V1::RewardsController < Api::V1::ApplicationController

	def mark_as_collected
		@reward = Reward.where(id: params[:id], is_collected: false).first
		@user = User.where(id: @reward.user_id).first
		coins = @user.coins + params[:coins].to_f
		ticket_bought = @user.ticket_bought + params[:tickets].to_f
		@user.update_attributes(coins: coins, ticket_bought: ticket_bought)
		if @reward.update_attributes(is_collected: true)
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