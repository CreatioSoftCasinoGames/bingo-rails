class LevelProgrationsController < ApplicationController
  before_action :set_level_progration, only: [:show, :edit, :update, :destroy]

  # GET /level_progrations
  # GET /level_progrations.json
  def index
    @level_progrations = LevelProgration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @level_progrations }
    end
  end

  # GET /level_progrations/1
  # GET /level_progrations/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @level_progration }
    end
  end

  # GET /level_progrations/new
  def new
    @level_progration = LevelProgration.new
  end

  # GET /level_progrations/1/edit
  def edit
  end

  # POST /level_progrations
  # POST /level_progrations.json
  def create
    @level_progration = LevelProgration.new(level_progration_params)

    respond_to do |format|
      if @level_progration.save
        format.html { redirect_to @level_progration, notice: 'Level progration was successfully created.' }
        format.json { render json: @level_progration, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @level_progration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /level_progrations/1
  # PATCH/PUT /level_progrations/1.json
  def update
    respond_to do |format|
      if @level_progration.update(level_progration_params)
        format.html { redirect_to @level_progration, notice: 'Level progration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @level_progration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /level_progrations/1
  # DELETE /level_progrations/1.json
  def destroy
    @level_progration.destroy
    respond_to do |format|
      format.html { redirect_to level_progrations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level_progration
      @level_progration = LevelProgration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def level_progration_params
      params.require(:level_progration).permit(:level, :xp, :xp_difference, :xp_per_daub, :coins_per_bingo, :tickets_per_bingo, :card_cost)
    end
end
