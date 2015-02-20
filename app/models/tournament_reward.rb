class TournamentReward < ActiveRecord::Base
	has_attached_file :file
	validates_attachment_presence :file
  # validates_attachment :file, content_type: { content_type: /\Afile\/.*\Z/ }
end
