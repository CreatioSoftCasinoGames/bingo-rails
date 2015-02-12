class Round < ActiveRecord::Base

  belongs_to :resource, polymorphic: true
  belongs_to :tournament, class_name: Tournament, foreign_key: "resource_id"
  has_many :tournament_users, through: :tournament
	before_create :create_deck
	has_many :users, through: :round_users
	has_many :round_users

	accepts_nested_attributes_for :users
	accepts_nested_attributes_for :round_users
  accepts_nested_attributes_for :tournament_users

	def deck
		YAML.load read_attribute(:deck)
	end

  def analize(data)
    params = {active: false}  
  	round_users_attributes = []
  	users_attributes = []
    tournament_users_attributes = []
  	data.each do |node_obj|
  		round_user = round_users.where(user_id: node_obj['playerId']).first
  		user = round_user.user
      coins = 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
  		round_users_attributes.push({
  			id: round_user.id,
  			daubs: node_obj['daubs'],
  			bingos: node_obj['bingo'],
        room_id: node_obj['room_id'],
        attempt_number: node_obj['attempt_number'],
        round_number: node_obj['round'],
        coins: coins
  		})
  		bingo_played = user.bingo_played.to_f + 1
  		total_daubs = user.total_daubs.to_f + node_obj['daubs'].to_f
      coins = 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
  		users_attributes.push({
  			id: user.id,
  			total_daubs: total_daubs,
  			bingo_played: bingo_played,
        tickets_purchased: node_obj['cards'],
        coins: coins
  		})
      tournament_user = TournamentUser.where(tournament_id: self.resource_id, user_id: user.id).first
      if tournament_user.present?
        score = tournament_user.score + 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
      else
        score = 2*node_obj['daubs'].to_f + 10*node_obj['bingo'].to_f
        tournament_user = TournamentUser.create(user_id: user.id, tournament_id: self.resource_id, score: score)
      end
      tournament_users_attributes.push({
        id: tournament_user.id,
        user_id: user.id,
        tournament_id: self.resource_id,
        score: score
      })
  	end
  	params[:round_users_attributes] = round_users_attributes
  	params[:users_attributes] = users_attributes
    params[:tournament_users_attributes] = tournament_users_attributes
  	self.update_attributes(params)
  end

	private

		def create_deck
			self.deck = (1..75).to_a.shuffle.to_yaml
		end

end