class FriendshipSerializer < ActiveModel::Serializer
	attributes :friend_token, :full_name
end