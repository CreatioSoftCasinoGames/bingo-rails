class BotsProbability < ActiveRecord::Base
	belongs_to :ai

	def self.get_bots
		bots_probability_map = {}
		limits = BotsProbability.all.collect {|b| [b.min_players, b.max_players]}.uniq.sort
		limits.each do |limit|
			bots_probability_map[limit.last] = []
			bots_probabilities = BotsProbability.all
			(1..10).to_a.each do |num_bots|
				bots_probability = bots_probabilities.select {|bp| (num_bots == bp.num_bots) && (limit[0] == bp.min_players) && (limit[1] == bp.max_players) }.first
				if bots_probability
					bots_probability_map[limit.last] << bots_probability.probability
				else
					bots_probability_map[limit.last] << 0.0
				end
			end
		end
		bots_probability_map
	end

end


