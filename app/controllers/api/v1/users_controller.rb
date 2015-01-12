class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :incr_bonus, :incr_total_daubs, :incr_ticket_bought, :incr_mystery_chests, :incr_daubs_collected, :incr_keys_collected, :incr_bingo_vertical, :incr_bingo_horizontal, :incr_bingo_diagonal, :incr_coins_collected]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: {
				user: @user,
				valid: true
			}
		else
			render json: {
				user: @user,
				valid: false,
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def show
		render json: @user
	end

	def update
		if @user.update(user_params)
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_total_daubs
		if @user.update_attributes({daubs: params[:daubs]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_ticket_bought
		if @user.update_attributes({ticket: params[:ticket]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bonus
		if @user.update_attributes({bonus: params[:bonus]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_mystery_chests
		if @user.update_attributes({mystery_chests: params[:mystery_chests]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_daubs_collected
		if @user.update_attributes({daubs_collected: params[:daubs_collected]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_keys_collected
		if @user.update_attributes({keys_collected: params[:keys_collected]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_vertical
		if @user.update_attributes({bingo_vertical: params[:bingo_vertical]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_horizontal
		if @user.update_attributes({bingo_horizontal: params[:bingo_horizontal]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_diagonal
		if @user.update_attributes({bingo_diagonal: params[:bingo_diagonal]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_coins_collected
		if @user.update_attributes({coins_collected: params[:coins_collected]})
			render json: @user
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :fb_id, :is_guest, :tokens, :coins, 
			:powerups_remaining, :keys, :bingo_win, :tickets_purchased, :current_level, :xp_earned, :achievements_won, :jigsaw_pieces_collected, :powerups_used, :bingo_played, :tournaments_participated, :tournaments_won, :best_tournament_position, 
			:best_bingo_position, :daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, in_app_purchase_attributes: [:amount, :title], powerup_attributes: [:free_cell, :instant_bingo, :mystery_chests, :reveal_and_daub, :double_payout, :free_coins])
	end

	def find_user
		@user = User.find(params[:id])
	end

end