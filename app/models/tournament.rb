class Tournament < ActiveRecord::Base
	has_many :tournament_users, :dependent => :destroy
	has_many :users, through: :tournament_users
	has_many :rounds, as: :resource

	accepts_nested_attributes_for :tournament_users
	
end