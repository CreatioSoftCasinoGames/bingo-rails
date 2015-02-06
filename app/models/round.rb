class Round < ActiveRecord::Base

	belongs_to :room
	before_create :create_deck
	has_many :users, through: :round_users
	has_many :round_users
	accepts_nested_attributes_for :users
	accepts_nested_attributes_for :round_users

	def deck
		YAML.load read_attribute(:deck)
	end

  def analyze(data)
  	round_users_attributes = []
  	users_attributes = []
  	data.each do |node_obj|
  		round_user = round_users.where(user_id: node_obj['playerId']).first
  		user = round_user.user
  		round_users_attributes.push({
  			id: round_user.id,
  			daubs: node_obj['daubs'],
  			bingo: node_obj['bingo']
  		})
  		bingo_played = user.bingo_played.to_f + 1
  		total_daubs = user.total_daubs.to_f + node_obj['daubs'].to_f
  		users_attributes.push({
  			id: user.id,
  			total_daubs: total_daubs,
  			bingo_played: bingo_played,
  			best_bingo_position: best_bingo_position
  		})
  	end
  	params[:round_users_attributes] = round_users_attributes
  	params[:users_attributes] = users_attributes
  	self.update_attributes(params)
  end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end