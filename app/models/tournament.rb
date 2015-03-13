class Tournament < ActiveRecord::Base
	
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :users, through: :tournament_users
  accepts_nested_attributes_for :tournament_users

  def self.mark_as_end
  	current_tournament = self.where(active: true).last
  	current_tournament.tournament_users.order("score DESC").limit(3).each_with_index do |tournament_user, i|
  		Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1)
  	end
  	current_tournament.update_attributes(active: false)
  	Tournament.create(room_id: current_tournament.room_id, active: true)
  end

end
