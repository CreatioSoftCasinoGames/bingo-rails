class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :get_round_and_attempt, :my_rank, :in_game_inapp]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: {
				user: @user,
				valid: true
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def show
		render json: @user
	end

	def update
		if @user.update(user_params)
			render json: {
				user: @user.as_json({
					only: user_params.keys
				})
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def get_round_and_attempt
		@round_user = @user.round_users.where(room_id: params[:room_id]).last
		reward = @user.rewards.where(is_collected: true)
		render json: {
			round_info: @round_user.as_json({
				only: [:round_number, :attempt_number]
			}),
			reward: reward
		}
	end

	def my_rank
		if params[:resource_type] == "tournament"
			round_one_score = @user.round_users.where(room_id: params[:room_id], round_number: 1).pluck(:score).max().to_f
			round_two_score = @user.round_users.where(room_id: params[:room_id], round_number: 2).pluck(:score).max().to_f
			round_three_score = @user.round_users.where(room_id: params[:room_id], round_number: 3).pluck(:score).max().to_f
			remaining_time = Tournament.last.created_at - Time.now + 24.hours
			rank = TournamentUser.order('score DESC').map(&:user_id).index(@user.id).to_f + 1
			is_over = Tournament.where(room_id: params[:room_id]).last.tournament_users.where(user_id: @user.id).pluck(:over).last
			render json: {
				round_one: round_one_score,
				round_two: round_two_score,
				round_three: round_three_score,
				remaining_time: remaining_time,
				rank: rank,
				is_over: is_over
			}
		else
			render json: nil
		end
	end

	def in_game_inapp
		if Tournament.where(room_id: params[:room_id]).last.tournament_users.where(user_id: @user.id).last.update_attributes(over: false)
			render json: {
				success: true
			}
		else
			render json: {
				success: false
			}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :fb_id, :is_guest, :tokens, :coins, 
			:powerups_remaining, :keys, :bingo_win, :tickets_purchased, :current_level, :xp_earned, :achievements_won, :jigsaw_pieces_collected, :powerups_used, :bingo_played, :tournaments_participated, :tournaments_won, :best_tournament_position, 
			:best_bingo_position, :ticket_bought, :total_daubs, :keys_collected_in_game, :free_daubs_collected, :mystery_chests_opened, :bounus_coins_and_tickets, :coins_collected_in_game, :bingo_by_corner_pattern, :bingo_by_horizontal_pattern, :bingo_by_vertical_pattern, :bingo_by_diagonal_pattern, :daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, in_app_purchases_attributes: [:amount, :title], powerup_attributes: [:free_cell, :instant_bingo, :mystry_chests, :reveal_and_daub, :double_payout, :free_coins, :id])
	end

	def find_user
		@user = User.where(login_token: params[:id]).first
		(render json: {message: "User not found", success: false} and return	) if @user.blank?
	end

end