class Api::V1::GiftRequestsController < Api::V1::ApplicationController
	
	before_action :get_gift_request, only: [:update, :destroy, :show]

	def create
		if params[:gift_type] == "coins"
			gift_value = 1000
		elsif params[:gift_type] == "tickets"
			gift_value = 5
		else
			gift_value: 2
		end
		
		is_asked = params[:is_asked].present? ? params[:is_asked] : false
		@gift_request = current_user.gift_requests_sent.build(send_token: params[:send_to_token], gift_type: params[:gift_type], is_asked: is_asked, gift_value: gift_value)
		if @gift_request.save
			render json: @gift_request
		else
			render json: {
					success: false,
					message: @gift_request.errors.full_messages.join(", ")
				} 
		end
	end

	def update
		if @gift_request.update_attributes(gift_request_params)
			render json: @gift_request
		else
			render json: @gift_request.errors.full_messages.join(", ")
		end
	end

	def destroy
		@gift_request.destroy
		render json: {
			success: true
		}
	end

	def show
		render json: @gift_request
	end

	private

	def gift_request_params
		params.require(:gift_request).permit(:confirmed)
	end

	def get_gift_request
		@gift_request = GiftRequest.where(id: params[:id]).first
		(render json: {message: "Gift request not found", success: false })  if @gift_request.blank?
	end

	def current_user
		User.find_by_login_token(params[:login_token])
	end

end