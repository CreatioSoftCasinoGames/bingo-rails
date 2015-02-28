class RoundUser < ActiveRecord::Base

	belongs_to :round
	belongs_to :user

	def is_over
		Tournament.where(room_id: room_id).last.tournament_users.where(user_id: user.id).pluck(:over).last
	end

end
