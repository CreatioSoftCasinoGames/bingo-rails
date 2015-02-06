class TournamentsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		Tournament.create(JSON.parse(data))
	end

end