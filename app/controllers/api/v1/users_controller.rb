class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :incr_bonus, :incr_daubs, :incr_ticket, :incr_mystery_chests, :incr_daubs_collected, :incr_keys_collected, :incr_bingo_vertical, :incr_bingo_horizontal, :incr_bingo_diagonal, :incr_coins_collected]

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

	User.incremental_feilds.each do |method_name|
		define_method "incr_#{method_name}" do
			if @user.update_attributes({method_name => params[method_name]})
				render json: @user
			else
				render json:{
					errors: @user.errors.full_messages.join(", ")
				}
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :fb_id, :is_guest, :tokens, :coins, 
			:powerups_remaining, :keys, :bingo_win, :tickets_purchased, :current_level, :xp_earned, :achievements_won, :jigsaw_pieces_collected, :powerups_used, :bingo_played, :tournaments_participated, :tournaments_won, :best_tournament_position, 
			:best_bingo_position, :daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, in_app_purchases_attributes: [:amount, :title], powerup_attributes: [:free_cell, :instant_bingo, :mystry_chests, :reveal_and_daub, :double_payout, :free_coins, :id])
	end

	def find_user
		@user = User.where(id: params[:id]).first
		(render json: {message: "User not found", success: false}) if @user.blank?
	end

end