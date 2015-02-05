class GameWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		Round.create(Json.parse(data))
	end

end