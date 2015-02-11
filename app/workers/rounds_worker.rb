class RoundsWorker
	include Sidekiq::Worker

	sidekiq_options retry: false

	def perform(data)
		k = JSON.parse(data)
		k["resource_id"] = Tournament.where(room_id: k["room_id"]).last.id
		Round.create(k)
	end

end