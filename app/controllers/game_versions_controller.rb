class GameVersionsController < ApplicationController
  before_action :set_game_version, only: [:show, :edit, :update, :destroy]

  # GET /game_versions
  # GET /game_versions.json
  def index
    if params[:device]
      @game_versions = GameVersion.where(device_type: params[:device])
    else
      @game_versions = GameVersion.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_versions }
    end
  end

  # GET /game_versions/1
  # GET /game_versions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_version }
    end
  end

  # GET /game_versions/new
  def new
    @game_version = GameVersion.new
  end

  # GET /game_versions/1/edit
  def edit
  end

  # POST /game_versions
  # POST /game_versions.json
  def create
    @game_version = GameVersion.new(game_version_params)

    respond_to do |format|
      if @game_version.save
        format.html { redirect_to @game_version, notice: 'Game version was successfully created.' }
        format.json { render json: @game_version, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @game_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_versions/1
  # PATCH/PUT /game_versions/1.json
  def update
    respond_to do |format|
      if @game_version.update(game_version_params)
        format.html { redirect_to @game_version, notice: 'Game version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_versions/1
  # DELETE /game_versions/1.json
  def destroy
    @game_version.destroy
    respond_to do |format|
      format.html { redirect_to game_versions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_version
      @game_version = GameVersion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_version_params
      params.require(:game_version).permit(:device_type, :version, :require_update)
    end
end
