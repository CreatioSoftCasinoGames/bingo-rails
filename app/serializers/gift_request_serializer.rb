class GiftRequestSerializer < ActiveModel::Serializer
	attributes :id, :user_login_token, :send_to_token, :is_asked, :confirmed, :full_name, :image_url
end