class Room < ActiveRecord::Base

	has_many :rounds, as: :resource
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"
	has_many :tournaments
	has_many :round_users

	def active_tournament
		tournaments.where(active: true).last
	end
	
	def my_rank(user_id)
		self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_f + 1
	end

	def find_tournament(room_id, user_id)
		tournament_user = TournamentUser.where(room_id: room_id, user_id: user_id).last
		if tournament_user.present?
			tournament_user.tournament
		end
	end

end
