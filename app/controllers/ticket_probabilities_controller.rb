class TicketProbabilitiesController < ApplicationController
  load_and_authorize_resource
  def index
  	@ticket_probabilities = TicketProbability.all
  	respond_to do |format|
      format.html 
    end
  end

  private

  def set_ticket_probability
      @ticket_probabilities = TicketProbability.find(params[:id])
    end

  def ticket_probability_params
      params.require(:ticketprobability).permit(:num_ticket, :probability, :room_id, :ai_id)
  end
end
