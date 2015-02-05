class RoundEndWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perfor(data)
		data = Json.parse(data)
		round = Round.where(round_id: data['round_id']).first
		round.analyze(data['players'])
	end
end