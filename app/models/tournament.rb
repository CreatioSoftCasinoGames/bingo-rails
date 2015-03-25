class Tournament < ActiveRecord::Base
	
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :users, through: :tournament_users
  accepts_nested_attributes_for :tournament_users

  def self.mark_as_end
    #End and start a daily bingo tournament
  	current_daily_tournament = self.where(active: true, tournament_type: "daily").last
  	current_daily_tournament.tournament_users.order("score DESC").limit(3).each_with_index do |tournament_user, i|
  		Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1)
  	end
  	current_daily_tournament.update_attributes(active: false)
  	Tournament.create(room_id: current_daily_tournament.room_id, active: true, tournament_type: "daily")

    #End and start a weekly bingo tournament
    weekly_tournaments = self.where(active: true, tournament_type: "weekly")
    if weekly_tournaments.present?
      current_weekly_tournament = weekly_tournaments.select {|weekly_tournament| weekly_tournament.created_at.to_date == (Time.now - 7.day).to_date}.first
      if current_weekly_tournament.present?
        current_weekly_tournament.tournament_users.order("score DESC").limit(3).each_with_index do |tournament_user, i|
          Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1)
        end
        current_weekly_tournament.update_attributes(active: false)
      end
      Tournament.create(room_id: weekly_tournaments.last.room_id, active: true, tournament_type: "weekly")
    # else
    #   Tournament.create(room_id: weekly_tournaments.last.room_id, active: true, tournament_type: "weekly")
    end

    #End and start a weekly bingo tournament
    monthly_tournaments = self.where(active: true, tournament_type: "monthly")
    if monthly_tournaments.present?
      current_monthly_tournament = monthly_tournaments.select {|monthly_tournament| monthly_tournament.created_at.to_date == (Time.now - 30.day).to_date}.first
      if current_monthly_tournament.present?
        current_monthly_tournament.tournament_users.order("score DESC").limit(3).each_with_index do |tournament_user, i|
          Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1)
        end
        current_monthly_tournament.update_attributes(active: false)
      end
      Tournament.create(room_id: monthly_tournaments.last.room_id, active: true, tournament_type: "monthly")
    # else
    #   Tournament.create(room_id: monthly_tournaments.last.room_id, active: true, tournament_type: "monthly")
    end

  end

end
