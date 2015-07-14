class Api::V1::UtilityController < Api::V1::ApplicationController

	def status
		ram = %x(free).split("  ")
		hdd = %x(df).split(" ")
		render json: {
			total_ram: ram[9],
			busy_ram: ram[8],
			free_hdd: hdd[10],
			busy_hdd: hdd[9]
		}
	end

end