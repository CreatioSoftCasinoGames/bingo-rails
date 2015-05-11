class RoundsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		round_data = JSON.parse(data)
		if round_data["resource_type"] == "Tournament"
			round_data["round_users_attributes"].each do |round_user|
				tournament_user = TournamentUser.where(room_config_id: round_data["room_config_id"], user_id: round_user["user_id"]).last
				if tournament_user.present?
					tournament = tournament_user.tournament
					if tournament.active
						round_data["resource_id"] = tournament.id
					else
						round_data["resource_id"] = Tournament.where(room_config_id: round_data["room_config_id"]).last.id
					end
				else
					round_data["resource_id"] = Tournament.where(room_config_id: round_data["room_config_id"]).last.id
				end
			end
		else
			round_data["resource_id"] = round_data["room_config_id"]
		end
		Round.create(round_data)
	end

end