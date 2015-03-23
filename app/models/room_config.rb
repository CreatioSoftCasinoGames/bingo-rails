class RoomConfig < ActiveRecord::Base
	has_many :rooms, :dependent => :destroy
end
