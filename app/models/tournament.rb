class Tournament < ActiveRecord::Base
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
	has_many :users
  has_many :leader_boards, :dependent => :destroy
	before_create :create_deck

	accepts_nested_attributes_for :round_users
	accepts_nested_attributes_for :users
	accepts_nested_attributes_for :leader_boards
	
	def deck
		YAML.load read_attribute(:deck)
	end

	def analize(data)
		params = {active: false}
		round_users_attributes = []
		users_attributes = []
    leader_boards_attributes = []
		data.each do |node_obj|
			round_user = round_users.where(user_id: node_obj['playerId']).first
  		user = round_user.user
  		round_users_attributes.push({
  			id: round_user.id,
  			daubs: node_obj['daubs'],
  			bingos: node_obj['bingo'],
  			coins: 2*node_obj['daubs'] + node_obj['bingo'],
        room_id: node_obj['room_id'],
        attempt_number: node_obj['attempt_number'],
        round: node_obj['round']
  		})
  		bingo_played = user.bingo_played.to_f + 1
  		total_daubs = user.total_daubs.to_f + node_obj['daubs'].to_f
  		coins = 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
  		users_attributes.push({
  			id: user.id,
  			total_daubs: total_daubs,
  			bingo_played: bingo_played,
  			coins: coins,
  			tickets_purchased: node_obj['cards']
  		})
  		score = 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
      p self
  		leader_boards_attributes.push({
  			id: LeaderBoard.where(tournament_id: self.id, user_id: user.id).first.try(:id),
        user_id: user.id,
  			room_id: node_obj['room_id'],
  			score: score
  		})
		end
		params[:round_users_attributes] = round_users_attributes
  	params[:users_attributes] = users_attributes
  	params[:leader_boards_attributes] = leader_boards_attributes
    p params
  	self.update_attributes(params)
	end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end
