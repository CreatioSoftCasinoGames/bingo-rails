class Room < ActiveRecord::Base

	belongs_to :room_config
	has_many :rounds, as: :resource
	has_one :active_round, -> { where(rounds: {active: true}) }, class_name: "Round"
	has_many :tournaments
	has_many :round_users
	before_save :set_name

	def active_tournament
		tournaments.where(active: true).last
	end
	
	def my_rank(user_id)
		self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_f + 1
	end

	def find_tournament(room_id, user_id)
		tournament_user = TournamentUser.where(room_id: room_id, user_id: user_id).last
		if tournament_user.present?
			if tournament_user.tournament.active
				tournament_user.tournament
			end
		end
	end

	private

	def set_name
		p "-----------------------------------------------------------------"
		p room_config.try(:name)
		count = (room_config.rooms.last.name.split(" ").last.to_i rescue 0)
		self.name = "#{room_config.try(:name)} #{count+1}"
		self.num_bingo_factor = room_config.num_bingo_factor
		self.divider = room_config.divider
	end

end
