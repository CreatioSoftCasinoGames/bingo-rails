class Tournament < ActiveRecord::Base
	has_many :tournament_users, :dependent => :destroy
	has_many :users, through: :tournament_users
	before_create :create_deck

	accepts_nested_attributes_for :tournament_users
	accepts_nested_attributes_for :users
	
	def deck
		YAML.load read_attribute(:deck)
	end

	def analize(data)
		params = {active: false}
		tournament_users_attributes = []
		users_attributes = []
		data.each do |node_obj|
			tournament_user = tournament_users.where(user_id: node_obj['playerId']).first
  		user = tournament_user.user
  		tournament_users_attributes.push({
  			id: tournament_user.id,
  			daubs: node_obj['daubs'],
  			bingos: node_obj['bingo'],
  			coins: 2*node_obj['daubs'] + node_obj['bingo'],
        room_id: node_obj['room_id'],
        attempt_number: node_obj['attempt_number'],
        round: node_obj['round']
  		})
  		bingo_played = user.bingo_played.to_f + 1
  		total_daubs = user.total_daubs.to_f + node_obj['daubs'].to_f
  		coins = 2*node_obj['daubs'].to_f + node_obj['bingo'].to_f,
  		users_attributes.push({
  			id: user.id,
  			total_daubs: total_daubs,
  			bingo_played: bingo_played,
  			coins: coins,
  			tickets_purchased: node_obj['cards']
  		})
		end
		params[:tournament_users_attributes] = tournament_users_attributes
  	params[:users_attributes] = users_attributes
  	self.update_attributes(params)
	end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end
