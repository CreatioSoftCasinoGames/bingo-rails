class DynamicIapSerializer < ActiveModel::Serializer
  attributes :id, :old_coins_value, :new_coins_value, :old_pricing, :new_pricing, :offer, :currency, :country, :iap_id
end
