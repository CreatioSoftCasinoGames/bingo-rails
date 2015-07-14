class UpdateIapsWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(iap_type)
		DynamicIap.where(iap_type: iap_type).update_all(is_active: false)
	end

end