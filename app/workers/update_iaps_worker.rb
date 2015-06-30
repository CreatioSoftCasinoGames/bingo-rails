class UpdateIapsWorker
	include Sidekiq::Worker
	options_for_sidekiq retry: false

	def perform(iap_type)
		deals = DynamicIap.where(id: iap_type)
		deals.update_all(is_active: false)
	end

end