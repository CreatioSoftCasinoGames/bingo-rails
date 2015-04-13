class Room < ActiveRecord::Base

	belongs_to :room_config
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"
	has_many :tournaments
	has_many :round_users
	before_save :set_name
	has_many :ticket_probabilities

	private

	def set_name
		count = (room_config.rooms.last.name.split(" ").last.to_i rescue 0)
		self.name = "#{room_config.try(:name)} #{count+1}"
		self.num_bingo_factor = room_config.num_bingo_factor
		self.divider = room_config.divider
	end

end
