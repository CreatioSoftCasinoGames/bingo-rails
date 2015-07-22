class Api::V1::RewardsController < Api::V1::ApplicationController

	def mark_as_collected
		@reward = Reward.where(id: params[:id], is_collected: false).first
		tournament_type = @reward.tournament.tournament_type
		coins = @reward.user.coins + @reward.coins
		tickets = @reward.user.ticket_bought + @reward.tickets
		if tournament_type == "Daily_Free"
			if @reward.update_attributes(is_collected: true, user_attributes: {id: @reward.user.id, coins: coins, ticket_bought: tickets, daily_fee_paid: false})
				@message = true
			else
				@message = false
			end
		elsif tournament_type == "Weekly"
			if @reward.update_attributes(is_collected: true, user_attributes: {id: @reward.user.id, coins: coins, ticket_bought: tickets, weekly_fee_paid: false})
				@message = true
			else
				@message = false
			end
		elsif tournament_type == "Monthly"
			if @reward.update_attributes(is_collected: true, user_attributes: {id: @reward.user.id, coins: coins, ticket_bought: tickets, monthly_fee_paid: false})
				@message = true
			else
				@message = false
			end
		end

		render json: {
			success: @message
		}
		
	end

end