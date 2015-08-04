class Friendship < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :friend, class_name: "User", foreign_key: :friend_id
	# after_create :publish_friend
	validates :friend_id, :user_id, presence: true

	def full_name
		[user.first_name, user.last_name].join(" ")
	end

	def device_avtar_id
		user.device_avtar_id
	end

	def friend_token
		friend.login_token
	end

	private

	def publish_friend
		friend = User.find(friend_id)
		user = User.find(user_id)
		REDIS_CLIENT.PUBLISH("friend_added", {
			publish_type: "friend_added", 
			login_token: user.login_token,
			friend_token: friend.login_token,
			full_name: friend.full_name,
			image_url: friend.image_url,
			is_online: friend.online,
			unique_id: unique_id
		}.to_json)
	end

end