class LeaderBoard < ActiveRecord::Base

	belongs_to :rounds
	belongs_to :tournament
	
end
