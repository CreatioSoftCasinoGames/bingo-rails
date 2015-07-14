class Api::V1::ScheduleMaintenancesController < Api::V1::ApplicationController
	def sm
		if params[:schedule_time].present?
			REDIS_CLIENT.PUBLISH("server_maintenance", {publish_type: "server_maintenance", message: "Server is going on maintenance at "+params[:schedule_time]+" !"}.to_json)
		else
			REDIS_CLIENT.PUBLISH("kick_from_game", {publish_type: "kick_from_game", message: "Server is going on Maintenance!!"}.to_json)
		end
	end
end