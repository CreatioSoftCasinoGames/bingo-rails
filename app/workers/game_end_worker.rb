class GameEndWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perfor(data)
		data = Json.parse(data)
		round = Round.where(uuid: data['round_uuid']).first
		round.analyze(data['players'])
	end
end