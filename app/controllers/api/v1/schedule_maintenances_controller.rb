class Api::V1::ScheduleMaintenancesController < Api::V1::ApplicationController
	def sm
		REDIS_CLIENT.PUBLISH("server_maintenance", {message: "Server is going on maintenance after 30 minutes!"})
		render json: {
			sucess: true
		}
	end
end