class AisController < ApplicationController
  load_and_authorize_resource
  before_action :set_ai, only: [:show, :edit, :update, :destroy, :bots_probabilities, :ticket_probabilities]
  
  def bots_probabilities
  end

  def ticket_probabilities
  end
  
  def bot_probabilities
    Ai.where(id: params[:id]).first.bots_probabilities.where(min_players: params[:min_players], max_players: params[:max_players]).delete_all
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  # GET /ais
  # GET /ais.json
  def index
    @ais = Ai.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ais }
    end
  end

  # GET /ais/1
  # GET /ais/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ai }
    end
  end

  # GET /ais/new
  def new
    @ai = Ai.new
  end

  # GET /ais/1/edit
  def edit
  end

  # POST /ais
  # POST /ais.json
  def create
    @ai = Ai.new(ai_params)

    respond_to do |format|
      if @ai.save
        format.html { redirect_to @ai, notice: 'Ai was successfully created.' }
        format.json { render json: @ai, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @ai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ais/1
  # PATCH/PUT /ais/1.json
  def update
    respond_to do |format|
      if @ai.update(ai_params)
        if params[:redirection_action]
          format.html { redirect_to "#{ai_url(@ai)}/#{params[:redirection_action]}", notice: 'Ai was successfully updated.' }
        else
          format.html { redirect_to @ai, notice: 'Ai was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ais/1
  # DELETE /ais/1.json
  def destroy
    @ai.destroy
    respond_to do |format|
      format.html { redirect_to ais_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ai
      @ai = Ai.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ai_params
      params.require(:ai).permit(:name, :active, :redirect_path, bots_probabilities_attributes: [:probability, :id, :min_players, :max_players, :num_bots],
                                                 ticket_probabilities_attributes: [:room_config_id, :num_ticket, :id, :probability])
    end
end