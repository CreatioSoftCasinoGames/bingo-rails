class Api::V1::InAppPurchaseController < Api::v1::ApplicationController
	before_action :find_in_app, only: [:update, :show]
	def create
		@in_app_purchase = InAppPurchase.new(in_app_purchase_params)
		if @in_app_purchase.save
			render json: @in_app_purchase
		else
			render json: {
				errors: @in_app_purchase.errors.full_messages.join(", ")
			}
	end
	def show
		render json: @in_app_purchase
	end
	def update
		if @in_app_purchase.update_attributes(in_app_purchase_params)
			render json: @in_app_purchase
		else
			render json:{
				errors: @in_app_purchase.errors.full_messages.join(", ")
			}
	end

	private

	def in_app_purchase_params
		params.require(:in_app_purchase).permit(:amount, :title)
	end

	def find_in_app
		@in_app_purchase = InAppPurchase.find(params[:id])
	end

end