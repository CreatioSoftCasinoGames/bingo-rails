class TournamentEndWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		data = JSON.parse(data)
		round = Tournament.where(uuid: data['round_uuid']).first
		round.analize(data['players'])
	end
end