class ClientBug < ActiveRecord::Base
	after_create :send_mail

	private

	def send_mail
		MailsWorker.perform_in(5.seconds, self.id)
	end

end
