class TournamentUser < ActiveRecord::Base
	
	belongs_to :tournament
	belongs_to :user

	def full_name
		user.full_name
	end

	def image_url
		user.image_url
	end

end
