class UserLogsController < ApplicationController

	def index
		@versions = User.where("unique_id=? OR first_name=?", params[:unique_id], params[:unique_id]).first.try(:versions).try(:paginate, {:page => params[:page], :per_page => 30}).try(:order, "created_at desc")
	end

end