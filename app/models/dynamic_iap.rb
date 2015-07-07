class DynamicIap < ActiveRecord::Base
	after_update :set_deal_as_false

	private

	def set_deal_as_false
		if self.changes.include?(:end_time)
			UpdateIapsWorker.perform_at(self.end_time.hour, "Special")
		end
	end

end
