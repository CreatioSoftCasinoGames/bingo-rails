class Api::V1::ClientBugsController < Api::V1::ApplicationController

	def create
	  @client_bug = ClientBug.new(exception: params[:exception])
    if @client_bug.save
      render json: @client_bug
    else
      render json: {
				success: false,
				message: @client_bug.errors.full_messages.join(", ")
			} 
    end
	end
end




