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

	def find_tournament_id(user_id)
		active_tournaments = self.tournaments.where(active: true)
		active_tournaments.each do |active_tournament|
			tournament = active_tournament.tournament_users.where(user_id: user_id).last
			if tournament.present?
				tournament_id = tournament.tournament_id
			end
		end
	end

end
