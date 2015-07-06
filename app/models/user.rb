class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_validation  :set_fb_password, :set_login_details, :bot_login_details, :set_fb_friends

  has_many :friend_requests, :dependent => :destroy, foreign_key: "requested_to_id"
  has_many :friend_requests_sent, :dependent => :destroy, foreign_key: "user_id", class_name: "FriendRequest"
  has_many :unconfirmed_friend_requests, -> { where(confirmed: false) }, class_name: "FriendRequest", foreign_key: "requested_to_id"
  has_many :friendships, :dependent => :destroy
  has_many :friends, through: :friendships
  has_many :in_app_purchases, :dependent => :destroy
  has_many :gift_requests, :dependent => :destroy, foreign_key: "send_to_id"
  has_many :gift_requests_sent, :dependent => :destroy, class_name: "GiftRequest", foreign_key: "user_id"
  has_many :unconfirmed_gift_request, -> { where(confirmed: false) }, class_name: "GiftRequest", foreign_key: "send_to_id"
  has_one :powerup, :dependent => :destroy
  has_many :tournament_users, :dependent => :destroy
  has_many :tournaments, through: :tournament_users
  has_many :round_users
  has_many :rewards
  has_many :login_histories, :dependent => :destroy
  # has_many :unconfirmed_gift_requests, -> { where(confirmed: false) }, class_name: "GiftRequest", foreign_key: "send_to_id"
  has_many :room_users, :dependent => :destroy
  has_many :rooms, :through => :room_users
  validate :increase_ticket_and_coins
  before_update :check_device_changed
  before_create :add_unique_id

  accepts_nested_attributes_for :in_app_purchases
  accepts_nested_attributes_for :powerup
  accepts_nested_attributes_for :login_histories
  attr_accessor :reward_coins, :reward_tickets, :fb_friends_list, :previous_login_token, :device_changed

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_ask_for_gift(friend_id)
    gift_sent = gift_requests_sent.where(gift_requests: {send_to_id: friend_id}).last
    if gift_sent.present?
      gift_sent.created_at < Time.now - 24.hours
    else
      true
    end
  end

  def ask_for_gift_in(friend_id)
    gift_sent = gift_requests_sent.where(send_to_id: friend_id).last
    if gift_sent.present?
      gift_sent.created_at - Time.now + 24.hours
    else
      0
    end
  end

  def player_since
  	created_at.strftime("%B,%Y")
  end

  def is_special_deal
    DynamicIap.where(iap_type: "Special", is_active: true).count == 3
  end

  def deal_end_time
    deal = DynamicIap.where(iap_type: "Special", is_active: true).first
    (deal.updated_at + deal.end_time.hours - Time.zone.now)
  end

  def daily_bonus_time_remaining
    (Date.today.at_midnight + 24.hours - Time.zone.now).to_i
  end

  def next_daily_bonus_time
    (Date.tomorrow.at_midnight + 24.hours - Time.zone.now).to_i
  end

  def full_name
    if first_name
      [first_name, last_name].join(" ")
    else
      "Guest User"
    end
  end

  def self.reset_daily_bonus
    User.update_all(is_daily_bonus_collected: false)
  end
  
  def image_url 
    if fb_id
      "http://graph.facebook.com/#{fb_id}/picture?height=64"
    end
  end

  def num_friend_request
    FriendRequest.where(requested_to_id: self.id, confirmed: false).count()
  end

  def num_gift_request
    GiftRequest.where(send_to_id: self.id, confirmed: false).count()
  end

  def round_scores(room_config_id, tournament_id)
    round_users = self.round_users
    round_one_score = round_users.select {|round_user| round_user.round_number == 1 && round_user.room_config_id == room_config_id && round_user.tournament_id == tournament_id}.max().try(:score)
    round_two_score = round_users.select {|round_user| round_user.round_number == 2 && round_user.room_config_id == room_config_id && round_user.tournament_id == tournament_id}.max().try(:score)
    round_three_score = round_users.select {|round_user| round_user.round_number == 3 && round_user.room_config_id == room_config_id && round_user.tournament_id == tournament_id}.max().try(:score)
    round_four_score = round_users.select {|round_user| round_user.round_number == 4 && round_user.room_config_id == room_config_id && round_user.tournament_id == tournament_id}.max().try(:score)
    round_five_score = round_users.select {|round_user| round_user.round_number == 5 && round_user.room_config_id == room_config_id && round_user.tournament_id == tournament_id}.max().try(:score)
    return {round_one_score: round_one_score, round_two_score: round_two_score, round_three_score: round_three_score, round_four_score: round_four_score, round_five_score: round_five_score}
  end

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  def self.fetch_by_login_token(login_token)
    self.where(login_token: login_token).first || LoginHistory.where(login_token: login_token).first.user
  end

  private

  def increase_ticket_and_coins
    if reward_coins && reward_tickets
      self.coins = coins + reward_coins.to_f
      self.ticket_bought = ticket_bought + reward_tickets.to_f
    end
  end

  def set_fb_password
    if fb_id
      generated_password = SecureRandom.hex(9)
      self.password = generated_password
      self.password_confirmation = generated_password    
    end
  end

  def set_login_details
    if is_guest
      generated_password = SecureRandom.hex(9)
      self.email = "guest_#{SecureRandom.hex(8)}@bingoapi.com"
      self.password = generated_password
      self.password_confirmation = generated_password
    end
  end

  def bot_login_details
    if is_bot
      generated_password = SecureRandom.hex(9)
      self.email = "bot_#{SecureRandom.hex(8)}@bingoapi.com"
      self.password = generated_password
      self.password_confirmation = generated_password
    end
  end

  def set_fb_friends
    unless fb_friends_list.blank?
      user_ids = User.where(fb_id: fb_friends_list).collect(&:id)
      friend_ids = self.friends.collect(&:id)
      new_friend_ids = user_ids - friend_ids
      deleted_friends_ids = friend_ids - user_ids
      new_friend_ids.each do |friend_id|
        if Friendship.where(user_id: self.id, friend_id: friend_id).blank? && self.id != friend_id
          Friendship.create(user_id: self.id, friend_id: friend_id)
          Friendship.create(user_id: friend_id, friend_id: self.id)
        end
      end
      deleted_friends_ids.each do |deleted_friend_id|
        Friendship.where(user_id: id, friend_id: deleted_friend_id).first.try(:delete)
        Friendship.where(user_id: deleted_friend_id, friend_id: id).first.try(:delete)
      end
    end
  end

  def add_unique_id
    unique_value = SecureRandom.hex(4)
    self.unique_id = unique_value
  end

  def check_device_changed
    self.device_changed = true if self.changes.include?(:device_id)
    true
  end

end
