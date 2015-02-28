class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_validation  :set_fb_password, :set_login_details

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
  has_many :tournaments
  has_many :round_users
  has_many :rewards
  has_many :login_histories, :dependent => :destroy
  validate :increase_ticket_and_coins
  validate :set_fb_friends

  accepts_nested_attributes_for :in_app_purchases
  accepts_nested_attributes_for :powerup
  accepts_nested_attributes_for :login_histories
  attr_accessor :reward_coins, :reward_tickets, :fb_friends_list

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def player_since
  	created_at.strftime("%B,%Y")
  end

  def full_name
    [first_name, last_name].join(" ")
  end
  
  def image_url 
    if fb_id
      "http://graph.facebook.com/#{fb_id}/picture"
    end
  end

  def round_scores
    round_users = self.round_users
    round_one_score = round_users.select {|round_user| round_user.round_number == 1}.max().score
    round_two_score = round_users.select {|round_user| round_user.round_number == 2}.max().score
    round_three_score = round_users.select {|round_user| round_user.round_number == 3}.max().score
    return {round_one_score: round_one_score, round_two_score: round_two_score, round_three_score: round_three_score}
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

  def set_fb_friends
    if fb_friends_list
      user_ids = User.where(fb_id: fb_friends_list).collect(&:id)
      friend_ids = self.friends.collect(&:id)
      new_friend_ids = user_ids - friend_ids
      deleted_friends_ids = friend_ids - user_ids
      new_friend_ids.each do |friend_id|
        Friendship.create(user_id: self.id, friend_id: friend_id)
        Friendship.create(user_id: friend_id, friend_id: self.id)
      end
      deleted_friends_ids.each do |deleted_friend_id|
        Friendship.where(user_id: self.id, friend_id: deleted_friend_id).first.delete
        Friendship.where(user_id: deleted_friend_id, friend_id: self.id).first.delete
      end
    end
  end

end
