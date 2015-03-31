class RoomConfigsController < ApplicationController
  before_action :set_room_config, only: [:show, :edit, :update, :destroy]

  # GET /room_configs
  # GET /room_configs.json
  def index
    @room_configs = RoomConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @room_configs }
    end
  end

  # GET /room_configs/1
  # GET /room_configs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room_config }
    end
  end

  # GET /room_configs/new
  def new
    @room_config = RoomConfig.new
  end

  # GET /room_configs/1/edit
  def edit
  end

  # POST /room_configs
  # POST /room_configs.json
  def create
    @room_config = RoomConfig.new(room_config_params)

    respond_to do |format|
      if @room_config.save
        format.html { redirect_to @room_config, notice: 'Room config was successfully created.' }
        format.json { render json: @room_config, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @room_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_configs/1
  # PATCH/PUT /room_configs/1.json
  def update
    respond_to do |format|
      if @room_config.update(room_config_params)
        format.html { redirect_to @room_config, notice: 'Room config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_configs/1
  # DELETE /room_configs/1.json
  def destroy
    @room_config.destroy
    respond_to do |format|
      format.html { redirect_to room_configs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_config
      @room_config = RoomConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_config_params
      params.require(:room_config).permit(:name, :room_type, :min_players, :max_players, :timeout, :num_bingo_factor, :divider)
    end
end
