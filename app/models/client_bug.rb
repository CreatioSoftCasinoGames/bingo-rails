class ClientBug < ActiveRecord::Base
	after_create :send_mail

	private

	def send_mail
		NotifyAdminUser.send_error_mail(self).deliver
	end

end
