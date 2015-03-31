class Tournament < ActiveRecord::Base
	
  belongs_to :room
  has_many :rounds, as: :resource
	has_many :round_users, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :users, through: :tournament_users
  accepts_nested_attributes_for :tournament_users

  def self.mark_as_end
    Tournament.create_tournament("Daily_Free", 1)
    Tournament.create_tournament("Weekly", 7)
    Tournament.create_tournament("Monthly", 30)
  end

  def self.create_tournament(room_config_name, num_days)
    room_config = RoomConfig.where(name: room_config_name).first
    tournaments = room_config.tournaments.where(active: true)
    if tournaments.present?
      genrate_rewards(type, num_days)
    end
    Tournament.create(room_config_id: RoomConfig.where(name: room_type).first.id, active: true, tournament_type: room_type)
  end

  def self.genrate_rewards(tournaments, num_days)
    current_tournament = tournaments.select {|weekly_tournament| weekly_tournament.created_at.to_date == (Time.now - num_days.days).to_date}.first
    if current_tournament.present?
      current_tournament.tournament_users.order("score DESC").limit(3).each_with_index do |tournament_user, i|
        Reward.create(tournament_id: tournament_user.tournament_id, user_id: tournament_user.user_id, rank: i+1)
      end
      current_tournament.update_attributes(active: false)
    end
  end

end
