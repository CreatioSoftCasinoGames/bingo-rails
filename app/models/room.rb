class Room < ActiveRecord::Base

	has_many :rounds
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"

end
