class DynamicIapSerializer < ActiveModel::Serializer
  attributes :id, :old_value, :new_value, :old_pricing, :new_pricing, :offer, :currency, :country, :iap_id, :deal_value, :more
end
