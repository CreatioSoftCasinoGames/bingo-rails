class Api::V1::DynamicIapsController < Api::V1::ApplicationController

	def index
		@dynamiciap = DynamicIap.where(country: params[:country])
		if @dynamiciap.present?
			render json: {
				success: true,
				data: @dynamiciap
			}
		else 
			render json: {
				success: false,
				data: nil
			}
		end
	end

	def normal_iap_list
		render json: DynamicIap.where(iap_type: "Normal").as_json({
			only: [:iap_type, :iap_id, :new_coins_value, :new_pricing, :offer, :currency, :country, :deal_value]
		})
	end

	def special_iap_list
		render json: DynamicIap.where(iap_type: "Special", is_active: true).as_json
	end

end