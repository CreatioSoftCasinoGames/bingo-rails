class RewardSerializer < ActiveModel::Serializer
	attributes :id, :tournament_id, :rank
end