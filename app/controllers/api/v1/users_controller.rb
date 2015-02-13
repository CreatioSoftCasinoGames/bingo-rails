class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :incr_bonus, :incr_daubs, :incr_ticket, :incr_mystery_chests, :incr_daubs_collected, :incr_keys_collected, :incr_bingo_vertical, :incr_bingo_horizontal, :incr_bingo_diagonal, :incr_bingo_corner, :incr_coins_collected, :get_round_and_attempt, :leader_board, :in_game_inapp]

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

	def incr_daubs
		if @user.update_attributes(daubs: params[:daubs])
			render json: {
				total_daubs: @user.total_daubs
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_ticket_bought
		if @user.update_attributes(ticket: params[:ticket])
			render json: {
				ticket_bought: @user.ticket_bought
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_bonus
		if @user.update_attributes(bonus: params[:bonus])
			render json: {
				bonus_coins_and_tickets: @user.bounus_coins_and_tickets
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_mystery_chests
		if @user.update_attributes(mystery_chests: params[:mystery_chests])
			render json: {
				mystery_chests_opened: @user.mystery_chests_opened
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_daubs_collected
		if @user.update_attributes(daubs_collected: params[:daubs_collected])
			render json: {
				free_daubs_collected: @user.free_daubs_collected
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_keys_collected
		if @user.update_attributes(keys_collected: params[:keys_collected])
			render json: {
				keys_collected_in_game: @user.keys_collected_in_game
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_bingo_vertical
		if @user.update_attributes(bingo_vertical: params[:bingo_vertical])
			render json: {
				bingo_by_vertical_pattern: @user.bingo_by_vertical_pattern
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_bingo_horizontal
		if @user.update_attributes(bingo_horizontal: params[:bingo_horizontal])
			render json: {
				bingo_by_horizontal_pattern: @user.bingo_by_horizontal_pattern
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_bingo_diagonal
		if @user.update_attributes(bingo_diagonal: params[:bingo_diagonal])
			render json: {
				binogo_by_diagonal_pattern: @user.bingo_by_diagonal_pattern
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_bingo_corner
		if @user.update_attributes(bingo_corner: params[:bingo_corner])
			render json: {
				bingo_by_corner_pattern: @user.bingo_by_corner_pattern
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def incr_coins_collected
		if @user.update_attributes(coins_collected: params[:coins_collected])
			render json: {
				coins_collected_in_game: @user.coins_collected_in_game
			}
		else
			render json: @user.errors.full_messages.join(", ")
		end
	end

	def get_round_and_attempt
		@round_user = @user.round_users.where(room_id: params[:room_id]).last
		@round_user = @round_user
		is_over = TournamentUser.where(tournament_id: 24, user_id: @user.id).pluck(:over).last
		render json: {
			round_info: @round_user.as_json({
				only: [:round_number, :attempt_number]
			}),
			is_over: is_over
		}
	end

	def leader_board
		round_one_score = @user.round_users.where(room_id: params[:room_id], round_number: 1).pluck(:score).max()
		round_two_score = @user.round_users.where(room_id: params[:room_id], round_number: 2).pluck(:score).max()
		round_three_score = @user.round_users.where(room_id: params[:room_id], round_number: 3).pluck(:score).max()
		remaining_time = Tournament.last.created_at - Time.now + 24.hours
		rank = TournamentUser.order('score DESC').map(&:user_id).index(@user.id).to_f + 1
		render json: {
			round_one: round_one_score,
			round_two: round_two_score,
			round_three: round_three_score,
			remaining_time: remaining_time,
			rank: rank
		}
	end

	def in_game_inapp
		if @user.tournaments.where(id: params[:tournament_id]).last.tournament_users.update_attributes(over: false)
			render json: {
				success: "Inapp Successfull!"
			}
		else
			render json: {
				errors: "Something wrong"
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
		(render json: {message: "User not found", success: false}) if @user.blank?
	end

end