class Reward < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	accepts_nested_attributes_for :user

	def tournament_type
		tournament.tournament_type
	end

end