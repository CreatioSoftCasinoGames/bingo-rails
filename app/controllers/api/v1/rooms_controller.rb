class Api::V1::RoomsController < Api::V1::ApplicationController

	before_action :find_room, only: [:show, :get_bingo_factor, :leader_board]

	def index
		render json: Room.all
	end

	def create
		@room = Room.new(room_config_id: params[:room_config_id])

		if @room.save
			render json: {
				room: @room.as_json({
					only: [:id, :name, :room_type, :timeout, :num_bingo_factor, :divider, :room_config_id, :round_number, :uuid]
					}),
				valid: true
			}
		else
			render json: {
				errors: @room.errors.full_messages.join(", "),
				valid: false
			}
		end
	end

	def get_bingo_factor
		render json: {
			bingo_factor: @room.as_json({
				only: [:num_bingo_factor, :divider]
			})
		}
	end

	def find_ticket_probability
    render json: TicketProbability.where(room_id: params[:id]).collect(&:probability)
	end

	def show
		render json: @room
	end

	private

	def find_room
		@room = Room.where(id: params[:id]).first
		(render json: {message: "Room not found", success: false}) if @room.blank?
	end

end