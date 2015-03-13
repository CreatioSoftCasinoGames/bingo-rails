class RoundsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		round_data = JSON.parse(data)
		if round_data["resource_type"] == "tournament"
			round_data["round_users_attributes"].each do |round_user|
				tournaments = TournamentUser.where(room_id: round_data["room_id"], user_id: round_user["user_id"]).last
				if tournaments.present?
					if tournaments.tournament.active
						round_data["resource_id"] = tournament.id
					else
						round_data["resource_id"] = Tournament.where(room_id: round_data["room_id"]).last.id
					end
				else
					round_data["resource_id"] = Tournament.where(room_id: round_data["room_id"]).last.id
				end
			end
		else
			round_data["resource_type"] = round_data["resource_type"].capitalize
			round_data["resource_id"] = round_data[:resource_type].constantize.where(room_id: round_data["room_id"]).last.id
		end
		Round.create(round_data)
	end

end