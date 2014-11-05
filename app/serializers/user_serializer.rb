class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :preferred_table_config_id, :email
end
