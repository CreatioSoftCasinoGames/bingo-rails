class GameVersion < ActiveRecord::Base
	before_save :force_update_app

	private

	def force_update_app
		users = User.where(device: self.device_type, game_version: self.version)
		if users.present?
			users.update_all(update_required: self.require_update)
		end
	end

end
