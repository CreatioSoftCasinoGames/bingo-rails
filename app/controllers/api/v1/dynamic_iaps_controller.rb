class Api::V1::DynamicIapsController < Api::V1::ApplicationController

	def index
		render json: DynamicIap.where(iap_type: params[:iap_type], currency: params[:currency], is_active: true)
	end

	# def normal_iap_list
	# 	render json: DynamicIap.where(iap_type: "Normal", country: params[:country]).as_json({
	# 		only: [:iap_type, :iap_id, :new_coins_value, :new_pricing, :offer, :currency, :country, :deal_value]
	# 	})
	# end

	# def special_iap_list
	# 	render json: DynamicIap.where(iap_type: "Special", is_active: true).as_json
	# end

end