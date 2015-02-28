class Room < ActiveRecord::Base

	has_many :rounds, as: :resource
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"
	has_many :tournaments

	def active_tournament
		tournaments.where(active: true).last
	end

	def my_rank(user_id)
		self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_f + 1
	end

end
