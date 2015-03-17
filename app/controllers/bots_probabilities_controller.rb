class BotsProbabilitiesController < ApplicationController
  def index
  	@bots_probabilities = BotsProbability.all
  	respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @botsprobabilities }
    end
  end

  private

  def set_bots_probability
      @round = BotsProbability.find(params[:id])
    end

  def bots_probability_params
      params.require(:botsprobability).permit(:min_players, :max_players, :no_of_bots, :probability, :ai_id)
  end
end
