class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_validation  :set_fb_password, :set_login_details

  has_many :in_app_purchases, :dependent => :destroy
  has_one :powerup, :dependent => :destroy
  has_many :tournaments
  has_many :round_users
  has_many :login_histories, :dependent => :destroy

  accepts_nested_attributes_for :in_app_purchases
  accepts_nested_attributes_for :powerup
  accepts_nested_attributes_for :login_histories

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

  def self.fetch_by_login_token(login_token)
    self.where(login_token: login_token).first || LoginHistory.where(login_token: login_token).first
  end

  private

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

end
