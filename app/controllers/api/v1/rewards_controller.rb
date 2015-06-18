class Api::V1::RewardsController < Api::V1::ApplicationController

	def mark_as_collected
		@reward = Reward.where(id: params[:id], is_collected: false).first
		coins = @reward.user.coins + @reward.coins
		tickets = @reward.user.ticket_bought + @reward.tickets
		if @reward.update_attributes(is_collected: true, user_attributes: {id: @reward.user.id, coins: coins, ticket_bought: tickets})
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