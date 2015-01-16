class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :incr_bonus, :incr_daubs, :incr_ticket, :incr_mystery_chests, :incr_daubs_collected, :incr_keys_collected, :incr_bingo_vertical, :incr_bingo_horizontal, :incr_bingo_diagonal, :incr_bingo_corner, :incr_coins_collected]

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

	#User.incremental_feilds.each do |method_name|
	#	define_method "incr_#{method_name}" do
	#		if @user.update_attributes({method_name => params[method_name]})
	#			render json: @user
	#		else
	#			render json:{
	#				errors: @user.errors.full_messages.join(", ")
	#			}
	#		end
	#	end
	#end
	
	def incr_daubs
		if @user.update_attributes({daubs: params[:daubs]})
			render json: {
				total_daubs: @user.total_daubs
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_ticket_bought
		if @user.update_attributes({ticket: params[:ticket]})
			render json: {
				ticket_bought: @user.ticket_bought
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bonus
		if @user.update_attributes({bonus: params[:bonus]})
			render json: {
				bonus_coins_and_tickets: @user.bonus_coins_and_tickets
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_mystery_chests
		if @user.update_attributes({mystery_chests: params[:mystery_chests]})
			render json: {
				mystery_chests_opened: @user.mystery_chests_opened
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_daubs_collected
		if @user.update_attributes({daubs_collected: params[:daubs_collected]})
			render json: {
				free_daubs_collected: @user.free_daubs_collected
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_keys_collected
		if @user.update_attributes({keys_collected: params[:keys_collected]})
			render json: {
				keys_collected_in_game: @user.keys_collected_in_game
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_vertical
		if @user.update_attributes({bingo_vertical: params[:bingo_vertical]})
			render json: {
				bingo_by_vertical_pattern: @user.bingo_by_vertical_pattern
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_horizontal
		if @user.update_attributes({bingo_horizontal: params[:bingo_horizontal]})
			render json: {
				bingo_by_horizontal_pattern: @user.bingo_by_horizontal_pattern
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_diagonal
		if @user.update_attributes({bingo_diagonal: params[:bingo_diagonal]})
			render json: {
				binogo_by_diagonal_pattern: @user.binogo_by_diagonal_pattern
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_bingo_corner
		if @user.update_attributes({bingo_corner: params[:bingo_corner]})
			render json: {
				bingo_by_corner_pattern: @user.bingo_by_corner_pattern
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", ")
			}
		end
	end

	def incr_coins_collected
		if @user.update_attributes({coins_collected: params[:coins_collected]})
			render json: {
				coins_collected_in_game: @user.coins_collected_in_game
			}
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
			:best_bingo_position, :daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, in_app_purchases_attributes: [:amount, :title], powerup_attributes: [:free_cell, :instant_bingo, :mystry_chests, :reveal_and_daub, :double_payout, :free_coins, :id])
	end

	def find_user
		@user = User.where(id: params[:id]).first
		(render json: {message: "User not found", success: false}) if @user.blank?
	end

end