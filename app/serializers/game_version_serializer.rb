class GameVersionSerializer < ActiveModel::Serializer
  attributes :id, :device_type, :version, :require_update
end
