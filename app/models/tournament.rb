class Tournament < ActiveRecord::Base
	has_many :tournament_users, :dependent => :destroy
	has_many :users, through: :tournament_users

	accepts_nested_attributes_for :tournament_users
	
end
