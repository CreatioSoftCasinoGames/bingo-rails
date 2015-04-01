class RoundUser < ActiveRecord::Base

	belongs_to :round
	belongs_to :user

	def is_over
		Room.where(room_id: room_id).first.active_tournament.tournament_users.where(user_id: user.id).first.over
	end

end
