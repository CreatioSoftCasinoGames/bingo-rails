class Api::V1::DynamicIapsController < Api::V1::ApplicationController

	def index
		if params[:iap_type].downcase == "special"
			@dynamic_iap = DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: params[:currency].upcase)
		else
			@dynamic_iap = DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: params[:currency].upcase, is_active: true)
		end
		if @dynamic_iap.present?
			render json: @dynamic_iap
		else
			render json: DynamicIap.where(iap_type: params[:iap_type].capitalize, currency: "USD", is_active: true)
		end
	end

end