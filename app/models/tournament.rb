class Tournament < ActiveRecord::Base
	
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
	has_many :users
  has_many :tournament_users, :dependent => :destroy
  accepts_nested_attributes_for :tournament_users

end
