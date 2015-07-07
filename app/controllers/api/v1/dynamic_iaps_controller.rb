class Api::V1::DynamicIapsController < Api::V1::ApplicationController

	def index
		@dynamic_iap = DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: params[:currency].upcase)
		if @dynamic_iap.present?
			render json: DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: params[:currency].upcase)
		else
			render json: DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: "USD")
		end
	end

end