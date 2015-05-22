class RoundEndWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		data = JSON.parse(data)
		p data	
		round = Round.where(uuid: data['round_uuid']).first
		round.analize(data['players'])
	end
end