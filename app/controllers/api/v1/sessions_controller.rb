class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:fb_id] && params[:device_id]
			if User.where(fb_id: params[:fb_id], device_id: params[:device_id]).present?
				@success = true
				@user = User.where(fb_id: params[:fb_id], device_id: params[:device_id]).first
			elsif User.where(fb_id: params[:fb_id]).present?
				@success = false
				@message = "Allready existed user"
				@progress_existed = true
			elsif User.where(device_id: params[:device_id]).first.fb_id.present?
				device_id = SecureRandom.hex(12)
				email = params[:fb_id]+"@facebook.com"
				@user = User.new(device_id: device_id, fb_id: params[:fb_id], email: email)
				if @user.save
					@success = true
				else
					@success = false
					@message = @user.errors.full_messages.join(", ")
				end
			else
				@user = User.where(device_id: params[:device_id]).first
				if @user.update_attributes(fb_id: params[:fb_id])
					@success = true
				else
					@success = false
					@message = @user.errors.full_messages.join(", ")
				end
			end
		else
			@user = User.where(device_id: params[:device_id], is_guest: true).first_or_initialize
			if @user.new_record?
				if @user.save
					@success = true
				else
					@success = false
					@message = @user.errors.full_messages.join(", ")
				end
			else
				@success = true
			end
		end
		if @success
			login_token = SecureRandom.hex(5)
			if @user.update_attributes(login_token: login_token, first_name: params[:first_name], last_name: params[:last_name], online: true, game_version: params[:game_version], device: params[:device], country: params[:country], currency: params[:currency], login_histories_attributes: {id: nil, active: true, login_token: login_token })
				REDIS_CLIENT.PUBLISH("friend_online", {publish_type: "friend_online", login_token: @user.login_token, online: true, friends_token: @user.friends.collect(&:login_token)}.to_json)
				@user.previous_login_token = @user.login_histories.order("created_at desc").limit(2).last.try(:login_token)
				render json: @user.as_json({
					only: [:id, :device_id, :powerups_remaining, :login_token, :fb_id, :is_daily_bonus_collected, :bingo_played, :first_name, :last_name, :email, :total_daubs, :tokens, :coins, :keys, :xp_earned, :current_level, :total_bingo, :total_card_used, :powerups_used, :total_jigsaw_completed, :jigsaw_data_string, :achievement_data_string, :total_free_spin_count, :total_scratch_count, :special_reward_timer, :ticket_bought, :country, :show_tutorial, :daily_fee_paid, :weekly_fee_paid, :monthly_fee_paid, :is_fb_connected, :total_iap_made, :unique_id, :is_daily_bonus_collected, :currency],
					methods: [:num_friend_request, :daily_bonus_time_remaining, :next_daily_bonus_time, :num_gift_request, :player_since, :image_url, :previous_login_token, :device_changed, :is_special_deal, :deal_end_time],
					include: [:powerup, :in_app_purchases]
				})
			else
				render json: {
					errors: @user.errors.full_messages.join(", "),
					success: false
				}
			end
		else
			render json: {
				errors: @message,
				success: @success,
				progress_existed: @progress_existed
			}
		end
	end

	def destroy
		@user = User.fetch_by_login_token(params[:id])
		if @user.present?
			login_history_id = @user.login_histories.where(login_histories: {login_token: params[:id]}).first.id
			if @user.update_attributes(online: false, login_histories_attributes: {id: login_history_id ,active: false})
				REDIS_CLIENT.srem("game_players", "game_player:#{params[:id]}")
				REDIS_CLIENT.PUBLISH("friend_online", {publish_type: "friend_online", login_token: @user.login_token, online: false, friends_token: @user.friends.collect(&:login_token)}.to_json)
				render json: {
					success: true,
					message: "You have been signed out successfully!"
				}
			else
				render json: {
					errors: @user.errors.full_messages.join(", "),
					success: false
				}
			end
		else
			render json: {
				success: false,
				message: "Session does not exists"
			}
		end
	end

end