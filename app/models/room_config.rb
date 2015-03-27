class RoomConfig < ActiveRecord::Base
	has_many :rooms, :dependent => :destroy
	has_many :ticket_probabilities
end
