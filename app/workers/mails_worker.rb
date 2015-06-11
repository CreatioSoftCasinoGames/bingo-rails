class MailsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(bug_id)
		data = ClientBug.find(bug_id)
		NotifyAdminUser.send_error_mail(data).deliver
	end

end