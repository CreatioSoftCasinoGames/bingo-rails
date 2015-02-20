class Room < ActiveRecord::Base

	has_many :rounds, as: :resource
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"
	has_many :tournaments

	def active_tournament
		tournaments.where(active: true).last
	end

end
