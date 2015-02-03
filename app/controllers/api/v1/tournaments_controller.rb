class Api::V1::TournamentsController < Api::V1::ApplicationController

	before_action :get_tournament, only: [:update, :show]
	def create
		@tournament = Tournament.new(tournament_params)
		if @tournament.save?
			render json: @tournament
		else
			render json:{
				errors: @tournament.errors.full_messages.join(", ")
			}
		end
	end

	def show
		render json: @tournament
	end

	def update
		if @tournament.update(tournament_params)
			render json: @tournament
		else
			render json: {
				errors: @tournament.errors.full_messages.join(", ")
			}
		end
	end

	private

	def tournament_params
		params.require(:tournament).permit(:name, :room_id, tournament_users_attributes: [:id, :user_id, :round, :daubs, :bingos, :coins, :attempt_number])
  end

  def get_tournament
  	@tournament = Tournament.where(id: params[:id]).first
  end

end