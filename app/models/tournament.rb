class Tournament < ActiveRecord::Base
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
	has_many :users
  has_many :leader_boards, :dependent => :destroy
	before_create :create_deck

end
