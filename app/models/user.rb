class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_update :set_daubs, :set_coins_collected, :set_bingo_diagonal, :set_bingo_vertical, :set_bingo_horizontal, :set_keys_collected, :set_daubs_collected, :set_mystry_chests, :set_bonus, :set_ticket

  before_validation  :set_fb_password, :set_login_details

  attr_accessor :daubs, :ticket, :bonus, :mystery_chests, :daubs_collected, :keys_collected, :bingo_vertical, :bingo_horizontal, :bingo_diagonal, :coins_collected

  has_one :in_app_purchase, :dependent => :destroy
  has_one :powerup, :dependent => :destroy

  accepts_nested_attributes_for :in_app_purchase
  accepts_nested_attributes_for :powerup

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def player_since
  	created_at.strftime("%B,%Y")
  end

  def self.incremental_feilds
    return [:daubs, :ticket, :bonus, :mystery_chests, :daubs_collected, :keys_collected, :bingo_vertical, :bingo_horizontal, :bingo_diagonal, :coins_collected]
  end

  private

  def set_daubs
  	if daubs
  		self.total_daubs = total_daubs + daubs.to_f
  	end
  end

  def set_ticket
  	if ticket_bought
  		self.ticket_bought = ticket_bought + ticket.to_f
  	end
  end

  def set_bonus
  	if bonus
  		self.bounus_coins_and_tickets = bounus_coins_and_tickets + bonus.to_f
  	end
  end

  def set_mystry_chests
  	if mystery_chests
  		self.mystery_chests_opened = mystery_chests_opened + mystery_chests.to_f
  	end
  end

  def set_daubs_collected
  	if daubs_collected
  		self.free_daubs_collected = free_daubs_collected + daubs_collected.to_f
  	end
  end

  def set_keys_collected
  	if keys_collected
  		self.keys_collected_in_game = keys_collected_in_game + keys_collected.to_f
  	end
  end

  def set_bingo_vertical
  	if bingo_vertical
  		self.bingo_by_vertical_pattern = bingo_by_vertical_pattern + bingo_vertical.to_f
  	end
  end

  def set_bingo_horizontal
  	if bingo_horizontal
  		self.bingo_by_horizontal_pattern = bingo_by_horizontal_pattern + bingo_horizontal.to_f
  	end
  end

  def set_bingo_diagonal
  	if bingo_diagonal
  		self.bingo_by_diagonal_pattern = bingo_by_diagonal_pattern + bingo_diagonal.to_f
  	end
  end

  def set_coins_collected
  	if coins_collected
  		self.coins_collected_in_game = coins_collected_in_game + coins_collected.to_f
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

end
