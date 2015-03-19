class TicketProbability < ActiveRecord::Base
	belongs_to :ai

	def self.get_tickets
		ticket_probability_map = {}
		Room.all.each do |room|
			ticket_probabilities = room.ticket_probabilities
			ticket_probability_map[room.id] = []
			(1..4).to_a.each do |num_ticket|
				ticket_probability = ticket_probabilities.select {|ticket_probability| ticket_probability.num_ticket == num_ticket }.first
				if ticket_probability
					ticket_probability_map[room.id] << ticket_probability.probability
				else
					ticket_probability_map[room.id] << 0.0
				end
			end
		end
		ticket_probability_map
	end

end
