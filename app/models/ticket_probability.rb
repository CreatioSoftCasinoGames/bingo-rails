class TicketProbability < ActiveRecord::Base
	belongs_to :ai
	belongs_to :room_config


	def self.get_tickets
		ticket_probability_map = {}
		room_configs = RoomConfig.all
		room_configs.each do |room_config|
			ticket_probabilities = room_config.ticket_probabilities
			ticket_probability_map[room_config.id] = []
			(1..4).to_a.each do |num_ticket|
				ticket_probability = ticket_probabilities.select {|ticket_probability| ticket_probability.num_ticket == num_ticket }.first
				if ticket_probability
					ticket_probability_map[room_config.id] << ticket_probability.probability
				else
					ticket_probability_map[room_config.id] << 0.0
				end
			end
		end
		ticket_probability_map
	end

end
