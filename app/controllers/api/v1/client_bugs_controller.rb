class Api::V1::ClientBugsController < Api::V1::ApplicationController

	def create
    p params[:bug_type]
    bug_type  = "BINGO - " + params[:bug_type]
    p bug_type
	  @client_bug = ClientBug.new(exception: params[:exception], bug_type: bug_type)
    if @client_bug.save
      render json: {
      	success: true
      }
    else
      render json: {
				success: false,
				message: @client_bug.errors.full_messages.join(", ")
			} 
    end
	end
end




