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

end