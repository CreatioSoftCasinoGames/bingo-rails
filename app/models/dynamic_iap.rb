class DynamicIap < ActiveRecord::Base
	after_update :set_deal_as_false

	private

	def set_deal_as_false
		UpdateIapsWorker.perform_at(self.end_time.from_now, "Special")
	end

end
