class Round < ActiveRecord::Base

	belongs_to :room
	before_create :create_deck

	def deck
		YAML.load read_attribute(:deck)
	end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end