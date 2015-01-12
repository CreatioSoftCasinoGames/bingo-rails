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

		render json: {
			user: UserSerializer.new(@user).as_json["user"],
			success: @success,
			error: @message
		}
	end

end