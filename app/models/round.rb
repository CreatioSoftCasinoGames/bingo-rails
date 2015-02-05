class Round < ActiveRecord::Base

	belongs_to :room
	before_create :create_deck
	has_many :users, through: :round_users
	has_many :round_users

	def deck
		YAML.load read_attribute(:deck)
	end

	def siblings
    self.resource.rounds.where(bundle_type: bundle_type)
  end

  def analyze(data)
  	
  end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end