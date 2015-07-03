class Api::V1::DynamicIapsController < Api::V1::ApplicationController

	def index
		render json: DynamicIap.where(iap_type: params[:iap_type], currency: params[:currency], is_active: true)
	end

end