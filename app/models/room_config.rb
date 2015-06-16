class RoomConfig < ActiveRecord::Base
	has_many :rooms, :dependent => :destroy
	has_many :ticket_probabilities
	has_many :tournaments, :dependent => :destroy
	has_many :rounds, as: :resource

	def active_tournament
		tournaments.where(active: true).last
	end

	def find_tournament(room_config_id, user_id)
		tournament_user = TournamentUser.where(room_config_id: room_config_id, user_id: user_id).last
		if tournament_user.present?
			p tournament_user.tournament
			if tournament_user.tournament.active
				tournament_user.tournament
			end
		end
	end

	def my_rank(user_id)

		my_rank = self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_i
		if my_rank > 0
			self.active_tournament.tournament_users.order('score DESC').map(&:user_id).index(user_id).to_f + 1
		else 
			0
		end
	end

end
