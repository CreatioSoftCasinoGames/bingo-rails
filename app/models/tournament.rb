class Tournament < ActiveRecord::Base
	
  belongs_to :room
  belongs_to :room_config
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :users, through: :tournament_users
  accepts_nested_attributes_for :tournament_users

  def next_round_begins
    Tournament.last.created_at + 1.day - Time.zone.now
  end

  def self.mark_as_end
    Tournament.create_tournament("Daily_Free", 1)
    Tournament.create_tournament("Weekly", 7)
    Tournament.create_tournament("Monthly", 30)
  end

  def self.create_tournament(room_config_name, num_days)
    room_config = RoomConfig.where(name: room_config_name).first
    tournaments = room_config.tournaments.where(active: true)
    if tournaments.present?
      genrate_rewards(tournaments, num_days)
    end
    Tournament.create(room_config_id: room_config.id, active: true, tournament_type: room_config_name)
  end

  def self.genrate_rewards(tournaments, num_days)
    current_tournament = tournaments.select {|tournament| tournament.created_at.to_date <= (Time.zone.now - num_days.days).to_date}.first
    if current_tournament.present?
      if current_tournament.tournament_type == "Daily_Free"
        current_tournament.tournament_users.order("score DESC").each_with_index do |tournament_user, i|
          if i == 0
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 5000, tickets: 50)
          elsif i == 1
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 3000, tickets: 30)
          elsif i == 2
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 1000, tickets: 20)
          else
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 300, tickets: 0)
          end
              
        end
      elsif current_tournament.tournament_type == "Weekly"
        current_tournament.tournament_users.order("score DESC").each_with_index do |tournament_user, i|
          if i == 0
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 12000, tickets: 50)
          elsif i == 1
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 8000, tickets: 30)
          elsif i == 2
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 6000, tickets: 20)
          else
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 500, tickets: 0)
          end
              
        end
      elsif current_tournament.tournament_type == "Monthly"
        current_tournament.tournament_users.order("score DESC").each_with_index do |tournament_user, i|
          if i == 0
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 25000, tickets: 50)
          elsif i == 1
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 18000, tickets: 30)
          elsif i == 2
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 6000, tickets: 20)
          else
            Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1, coins: 1000, tickets: 0)
          end
              
        end
      end
        
          
      current_tournament.update_attributes(active: false)
    end
  end

end
