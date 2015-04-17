class Api::V1::UsersController < Api::V1::ApplicationController
	before_action :find_user, only: [:update, :show, :get_round_and_attempt, :my_rank, :game_data, :in_game_inapp, :friend_request_sent, :my_friend_requests, :my_friends, :sent_gift, :received_gift, :ask_for_gift_to, :ask_for_gift_by, :player_rank]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: {
				user: @user,
				success: true
			}
		else
			render json: {
				errors: @user.errors.full_messages.join(", "),
				success: false
			}
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
			render json: {
				errors: @user.errors.full_messages.join(", "),
				success: false
			}
		end
	end

	def friend_request_sent
		render json: @user.friend_requests_sent.where(confirmed: false)
	end

	def my_friend_requests
		render json: @user.unconfirmed_friend_requests.where(confirmed: false)
	end

	def send_in_game_gift
		render json: InGameGift.all
	end

	def my_friends
		render json: @user.friends.as_json({
			only: [:login_token, :online],
			methods: [:full_name, :image_url]
		})
	end

	def sent_gift
		render json: @user.gift_requests_sent.where(is_asked: false)
	end

	def received_gift
		render json: @user.unconfirmed_gift_requests.where(is_asked: false, confirmed: false)
	end

	def ask_for_gift_to
		render json: @user.gift_requests_sent.where(is_asked: true)
	end

	def ask_for_gift_by
		render json: @user.unconfirmed_gift_requests.where(is_asked: true)
	end

	def get_round_and_attempt
		@round_user = @user.round_users.where(room_config_id: params[:room_id]).last
		# @room = Room.where(id: params[:room_id]).first
		tournament_user = @user.tournament_users.where(room_config_id: params[:room_id]).last
    if tournament_user.present? && tournament_user.tournament.tournament_type == "Weekly" && @round_user.updated_at.to_date < Time.now.to_date
      @round_user.update_attributes(round_number: 0)
    elsif tournament_user.present? && tournament_user.tournament.tournament_type == "Monthly" && @round_user.updated_at.to_date < Time.now.to_date
    	@round_user.update_attributes(round_number: 0)
    end
		render json: {
			round_info: @round_user.as_json({
				only: [:round_number, :attempt_number]
			})
		}
	end

	def my_rank
		if params[:resource_type] == "Tournament"
			@room_config = RoomConfig.where(id: params[:room_config_id]).first
			@tournament = @room_config.find_tournament(@room_config.id, @user.id)
			if @tournament.present?
				@round_scores = @user.round_scores(@room_config.id, @tournament.id)
				rank = @tournament.tournament_users.order('score DESC').map(&:user_id).index(@user.id).to_f + 1
				@is_over = @tournament.tournament_users.where(user_id: @user.id).last
				@reward = @user.rewards.where(is_collected: false, tournament_id: @tournament.id).first
				remaining_time = @tournament.created_at - Time.now + @room_config.duration.day
			end
			render json: {
				round_one: @round_scores.present? ? @round_scores[:round_one_score] : 0,
				round_two: @round_scores.present? ? @round_scores[:round_two_score] : 0,
				round_three: @round_scores.present? ? @round_scores[:round_three_score] : 0,
				round_four: @round_scores.present? ? @round_scores[:round_four_score] : 0,
				round_five: @round_scores.present? ? @round_scores[:round_five_score] : 0,
				remaining_time: remaining_time.present? ? remaining_time : 0,
				rank: rank.present? ? rank : 0,
				is_over: @is_over.present? ? @is_over.over : false,
				reward_collected: @reward.present? ? @reward.is_collected : true,
				tournament_type: @tournament.present? ? @tournament.tournament_type : nil,
				reward_id: @reward.present? ? @reward.id : nil
			}
		else
			render json: {
				my_rank: nil
			}
		end
	end

	# def get_online_players
	# 	room_map = {}
	# 	rooms = RoomConfig.where(room_type: params[:room_type]).first.rooms
	# 	rooms.each do |room|
	# 		room_map[room.room_config_id] = User.where(id: room.round_users.collect(&:user_id), online: true).count
	# 	end
	# 	render json: room_map
	# end

	def player_rank
		if params[:room_type].capitalize == "Tournament"
			rank_map = {}
			room_configs = RoomConfig.where(room_type: params[:room_type])
			room_configs.each do |room_config|
				@tournament = room_config.find_tournament(room_config.id, @user.id)
				if @tournament.present?
					rank_map[room_config.id] = @tournament.tournament_users.order('score DESC').map(&:user_id).index(@user.id).to_f + 1
				else
					rank_map[room_config.id] = 0
				end
			end
			render json: rank_map
		else
			render json:{
				error: "This is not a Tournament!"
			}
		end
	end

	def game_data
		render json: @user.as_json({
			only: [:coins, :ticket_bought, :keys, :powerups_remaining, :xp_earned, :current_level, :total_daubs, 
				     :total_bingo, :total_card_used, :powerups_used, :total_jigsaw_completed, :jigsaw_data_string, 
				     :achievement_data_string, :total_scratch_count, :daily_bonus_time_remaining, :special_reward_timer
				    ]
		})
	end

	def in_game_inapp
		@room_config = RoomConfig.where(id: params[:room_config_id]).first
		if @room_config.active_tournament.tournament_users.where(user_id: @user.id).last.update_attributes(over: false)
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
			:powerups_remaining, :keys, :bingo_win, :tickets_purchased, :current_level, :xp_earned, :achievements_won, :jigsaw_pieces_collected, 
			:powerups_used, :bingo_played, :tournaments_participated, :tournaments_won, :best_tournament_position, 
			:best_bingo_position, :ticket_bought, :total_daubs, :keys_collected_in_game, :free_daubs_collected, :mystery_chests_opened, :bounus_coins_and_tickets, 
			:coins_collected_in_game, :bingo_by_corner_pattern, :bingo_by_horizontal_pattern, :bingo_by_vertical_pattern, :bingo_by_diagonal_pattern, 
			:daily_free_tickets_available, :is_invited_facebook_friend, :is_gifted_to_friend, :is_bingo_on_all_card, :fastest_bingo, 
			:total_jigsaw_completed, :total_bing, :total_daily_participitated, 
			:total_weekly_participated, :total_card_used, :total_monthly_participated,
			:total_daily_won, :total_weekly_won, :jigsaw_data_string, :total_monthly_won, 
			:achievement_data_string, :best_daily_position, :best_monthly_position, :best_weekly_position,
			:best_special_position, :total_free_spin_count, :total_scratch_count, :daily_bonus_time_remaining, 
			:special_reward_timer, :total_room_unlocked,
			in_app_purchases_attributes: [:amount, :title], powerup_attributes: [:free_cell, :instant_bingo, :mystry_chests, :reveal_and_daub, :double_payout, :free_coins, :id])
	end

	def find_user
		@user = User.where(login_token: params[:id]).first
		(render json: {message: "User not found", success: false} and return	) if @user.blank?
	end

end