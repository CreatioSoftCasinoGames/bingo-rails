class DynamicIap < ActiveRecord::Base
	after_update :set_deal_as_false

	private

	def set_deal_as_false
		UpdateIapsWorker.perform_in(self.end_time, "Special")
	end

end
