class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:fb_id]
			@user = User.where(fb_id: params[:fb_id]).first_or_initialize
			if @user.new_record?
				@user.attributes = {email: params[:email], first_name: params[:first_name], last_name: params[:last_name]}
				if @user.save
					@success = true
				else
					@success = false
					@message = @user.errors.full_messages.join(", ")
				end
			end
		else
			if params[:email] && params[:password]
				@user = User.where(email: params[:email]).first
				(@user = nil) unless @user.valid_password?(params[:password])
				@success = !@user.blank? 
			else
				if params[:is_guest] && params[:device_id]
					@user = User.where(device_id: params[:device_id], is_guest: true).first_or_initialize
					if @user.new_record?
						if @user.save
							@success = true
						else
							@success = false
							@message = @user.errors.full_messages.join(", ")
						end
					end
				end
			end
		end

		if @user.present?
			@user.update_attributes(login_token: SecureRandom.hex(5))
			LoginHistory.create(active: 1, user_id: @user.id, login_token: @user.login_token)
		end

		render json: {
			user: UserSerializer.new(@user).as_json["user"],
			success: @success,
			error: @message
		}
	end

	def destroy
		@user = User.where(login_token: params[:id]).first
		if @user.present?
			login_history_id = LoginHistory.where(login_token: params[:id]).first.id
			LoginHistory.update(login_history_id, active: 0)
			@user.update_attributes(login_token: "")
			session[:user_id] = nil
			REDIS_CLIENT.srem("game_players", "game_player:#{params[:id]}")
			render json: {
				success: true,
				message: "You have been signed out successfully!"
			}
		else
			render json: {
				success: false,
				message: "Session does not exists"
			}
		end
	end

end