class TournamentUser < ActiveRecord::Base
	
	belongs_to :tournament
	belongs_to :user

	def full_name
		if user.present?
			user.full_name
		else
			"Guest User"
		end
	end

	def image_url
		if user.present?
			user.image_url
		else
			" "
		end
	end

end
